import os
import requests
from bs4 import BeautifulSoup

# Конфигурация для Google Custom Search и OpenAI
API_KEY = os.environ["GOOGLE_API_KEY"]
SEARCH_ENGINE_ID = os.environ["GOOGLE_SEARCH_ENGINE_ID"]
OPENAI_API_KEY = os.environ["OPENAI_API_KEY"]
COUNTRIES = ["Великобританию", "США", "Бразилию", "Германию", "Турцию", "ОАЭ", "Францию", "Португалию", "Ирландию", "Испанию"]
COUNTRIES_ENG = {"Великобританию": "UK", "США": "US", "Бразилию": "Brazil", "Германию": "Germany", "Турцию": "Turkey", "ОАЭ": "Emirates", "Францию": "France", "Португалию": "Portugal", "Ирландию": "Ireland", "Испанию": "Spain"}
MAIN_POINTS = ["граница", "виза", "билеты", "документы"]
MAIN_POINTS_ENG = {"граница": "borders", "виза": "visa", "билеты": "tickets", "документы": "documents1"}

def main(country):
    query = f"Условия для въезда российских граждан в {country}"
    urls = google_search(query)
    #print (urls)
    #print ("")
    for main_point in MAIN_POINTS:
        all_paragraphs = []
        for url in urls:
            paragraphs = parse_html(url, main_point)
            all_paragraphs.extend(paragraphs)

        result = send_to_openai(all_paragraphs)
        #print(f"{main_point}:")
        #print("Полученная из интернета информация:")
        #print(all_paragraphs)
        #print("")
        #print("Ответ chat gpt:")
        #print(result['choices'][0]['message']['content'])
        #print("\n********************\n********************\n********************\n")
        insert_in_json(country, main_point, result['choices'][0]['message']['content'])
    print (json_file.data)

def google_search(query):
    url = f"https://www.googleapis.com/customsearch/v1?q={query}&cx={SEARCH_ENGINE_ID}&key={API_KEY}"
    try:
        response = requests.get(url)
    except requests.exceptions.RequestException as e:
        print('Network error occurred:', e)
        return None

    if response:
        search_results = response.json()
        # Извлечение URL из результатов поиска
        urls = [item['link'] for item in search_results.get('items', [])[:2]]
        return urls
    else:
        return None

def parse_html(url, main_point):
    try:
        response = requests.get(url)
        html_content = response.text  # Используем текстовое содержимое ответа
    except requests.exceptions.RequestException as e:
        print('Network error occurred:', e)
        return None

    if html_content:
        paragraphs = key_words_parsing(main_point, html_content)
        return paragraphs
    else:
        return None

def key_words_parsing(key_word, html_content):
    soup = BeautifulSoup(html_content, 'html.parser')
    if key_word == "граница":
        paragraphs = [p_tag.get_text() for p_tag in soup.find_all('p') if ((key_word in p_tag.get_text().lower() or "границы" 
                                                                            in p_tag.get_text().lower() or "границой" in p_tag.get_text().lower() or "границу" in p_tag.get_text().lower()) 
                                                                            and ("COVID-19" not in p_tag.get_text() and "covid-19" not in p_tag.get_text() and "ковид" not in p_tag.get_text().lower()))]
    elif key_word == "виза":
        paragraphs = [p_tag.get_text() for p_tag in soup.find_all('p') if ((key_word in p_tag.get_text().lower() or "визы" 
                                                                            in p_tag.get_text().lower() or "визой" in p_tag.get_text().lower() or "визу" in p_tag.get_text().lower()) 
                                                                            and ("COVID-19" not in p_tag.get_text() and "covid-19" not in p_tag.get_text() and "ковид" not in p_tag.get_text().lower()))]
    elif key_word == "билеты":
        paragraphs = [p_tag.get_text() for p_tag in soup.find_all('p') if ((key_word in p_tag.get_text().lower() or "билет" 
                                                                            in p_tag.get_text().lower() or "билетом" in p_tag.get_text().lower() or "билетами" in p_tag.get_text().lower() or "рейсы" in p_tag.get_text().lower() or "рейсами" in p_tag.get_text().lower()) 
                                                                            and ("COVID-19" not in p_tag.get_text() and "covid-19" not in p_tag.get_text() and "ковид" not in p_tag.get_text().lower()))]
    elif key_word == "документы":
        paragraphs = [p_tag.get_text() for p_tag in soup.find_all('p') if (key_word in p_tag.get_text().lower() or "документ" 
                                                                            in p_tag.get_text().lower() or "загранпаспорт" in p_tag.get_text().lower() or "страховка" in p_tag.get_text().lower() or "страховку" in p_tag.get_text().lower() or "страховкой" in p_tag.get_text().lower()) ]
    return paragraphs

def send_to_openai(paragraphs):
    messages = [
        {"role": "system", "content": "Вы являетесь помощником."},
        {"role": "user", "content": f"Сократи данный текст до одного абзаца. Важно, чтобы в нем присутствовала самая важная информация:"},
        {"role": "user", "content": "\n\n".join(paragraphs)}
    ]
    data = {
        "model": "gpt-4",
        "messages": messages,
        "max_tokens": 500
    }
    headers = {
        "Authorization": f"Bearer {OPENAI_API_KEY}"
    }
    try:
        response = requests.post("https://api.openai.com/v1/chat/completions", headers=headers, json=data)
    except requests.exceptions.RequestException as e:
        print('Network error occurred:', e)
    
    if response:
        return response.json()
    else:
        return None

class json_file:
    data = {
        "request": [
        {
        "id": 1,
        "name": "",
        "borders": "",
        "tickets": "",
        "visa": "",
        "documents1": "",
        "documents2": "",
        "discription": ""
        }
        ]
    }

def insert_in_json(name_of_country, which_point, gpt_answer):
    json_file.data["request"][0]["name"] = COUNTRIES_ENG[name_of_country]
    json_file.data["request"][0][MAIN_POINTS_ENG[which_point]] = gpt_answer

main(COUNTRIES[0])

#print (json_file.data)