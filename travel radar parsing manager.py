import requests
from bs4 import BeautifulSoup
from google.cloud import storage
import json
import os

# Конфигурация для Google Custom Search и OpenAI
API_KEY = ""
SEARCH_ENGINE_ID = ""
OPENAI_API_KEY = ""
COUNTRIES_RUS_1 = ["Великобританию", "США", "Бразилию", "Германию", "Турцию", "ОАЭ", "Францию", "Португалию", "Ирландию", "Испанию"]
COUNTRIES_RUS_2 = {"Великобританию": "Великобритания", "США": "США", "Бразилию": "Бразилия", "Германию": "Германия", "Турцию": "Турция", "ОАЭ": "Объединённые Арабские Эмираты", "Францию": "Франция", "Португалию": "Португалия", "Ирландию": "Ирландия", "Испанию": "Испания"}
COUNTRIES_ENG = {"Великобританию": "UK", "США": "USA", "Бразилию": "Brazil", "Германию": "Germany", "Турцию": "Turkey", "ОАЭ": "Emirates", "Францию": "France", "Португалию": "Portugal", "Ирландию": "Ireland", "Испанию": "Spain"}
MAIN_POINTS = ["граница", "виза", "билеты", "документы"]
MAIN_POINTS_ENG = {"граница": "borders", "виза": "visa", "билеты": "tickets", "документы": "documents"}
EXTENDED_URL_LIST = []
next_url = 4
bucket_name = "travel_radar"
country_name = "CountryName"
which_try = 0
check = True
gpt_calls_count = 0

def main(country):
    global check
    global which_try
    global gpt_calls_count
    query = f"Условия для въезда российских граждан в {country}."
    json_file_name = f"{COUNTRIES_ENG[country]}.json"
    folder_name = COUNTRIES_RUS_2[country]
    json_file_path = os.path.join(folder_name, f"{COUNTRIES_ENG[country]}.json")
    urls = google_search(query)
    print(country)
    print(country)
    print(country)
    print (urls)
    print ("")
    for main_point in MAIN_POINTS:
        print(main_point + ":")
        all_paragraphs = []
        all_paragraphs_to_check = []
        check = True
        which_try = 0
        text_file_path = os.path.join(folder_name, f"{COUNTRIES_RUS_2[country]} {main_point}.txt")
        new_text_file_path = os.path.join(folder_name, f"{COUNTRIES_RUS_2[country]} {main_point} new.txt")
        json_file_path = os.path.join(folder_name, f"{COUNTRIES_ENG[country]}.json")

        if main_point == "граница":
            if country == "Великобританию":
                paragraphs = parse_html(f"https://www.tutu.ru/geo/united_kingdom/article/open/", main_point, country)
                all_paragraphs.append(paragraphs)
                all_paragraphs_to_check.append(paragraphs)
            elif country == "ОАЭ":
                paragraphs = parse_html(f"https://www.tutu.ru/geo/united_arab_emirates/article/open/", main_point, country)
                all_paragraphs.append(paragraphs)
                all_paragraphs_to_check.append(paragraphs)
            else:
                paragraphs = parse_html(f"https://www.tutu.ru/geo/{COUNTRIES_ENG[country].lower()}/article/open/", main_point, country)
                all_paragraphs.append(paragraphs)
                all_paragraphs_to_check.append(paragraphs)

        else:
            for url in urls:
                try:
                    paragraphs = parse_html(url, main_point, country)
                    all_paragraphs.extend(paragraphs)
                    all_paragraphs_to_check.extend(paragraphs)
                    all_paragraphs_to_check.append(f"*********{url}*********")
                except:
                    continue
                which_try += 1
                if not (check):
                    break

        print(all_paragraphs_to_check)
        print("\n\n\n")

        create_file(new_text_file_path, all_paragraphs)

        same_or_not_check = check_if_same(text_file_path, new_text_file_path)

        if main_point != "граница":
            os.remove(text_file_path) 
                
            os.rename(new_text_file_path, text_file_path)
                
            result = send_to_openai(all_paragraphs)
            gpt_calls_count += 1
            print("Ответ chat gpt:")
            try:
                print(result['choices'][0]['message']['content'])
            except:
                None
            print("\n********************\n********************\n********************\n")
            try:
                insert_in_json(country, main_point, result['choices'][0]['message']['content'])
            except:
                None

        elif main_point == 'граница':
            os.remove(text_file_path) 
                
            os.rename(new_text_file_path, text_file_path)

            try:
                insert_in_json(country, main_point, paragraphs)
            except:
                None

        '''elif same_or_not_check == "Same" or same_or_not_check == "2 in 1":
            os.remove(new_text_file_path) 

            with open(json_file_path, 'r', encoding='utf-8') as file:
                data = json.load(file)
                
            # Получение доступа к значению "name" в массиве "request"
            same_data = data["data"]["request"][0][main_point]

            try:
                insert_in_json(country, main_point, same_data)
            except:
                None'''

        print(same_or_not_check)

    # Запись данных в JSON-файл и загрузка его на GCS
    with open(json_file_path, 'w') as file:
        json.dump(json_file.data, file, indent=4)

    delete_blob(bucket_name, json_file_name)

    upload_blob(bucket_name, json_file_path, json_file_name)
    make_blob_public(bucket_name, json_file_name)
    print("Файл был успешно загружен!")
    print("|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n")

def create_file(file_path, data):
    with open(file_path, 'w') as file:
        file.write(str(data))
    
def check_if_same(old_file, new_file):    
    f = open(old_file, 'r')
    file1 = f.read()
    f.close()
    f = open(new_file, 'r')
    file2 = f.read()
    f.close()

    if file1 == file2:
        return "Same"
    else:
        checker_1_in_2 = True
        for element in file1:
            if element in file2:
                continue
            else:
                checker_1_in_2 = False
                checker_2_in_1 = True
                for element1 in file2:
                    if element1 in file1:
                        continue
                    else:
                        checker_2_in_1 = False
                break
        if checker_1_in_2 == True:
            return "1 in 2"
        elif checker_2_in_1 == True:
            return "2 in 1"
        else:
            return "Completely new"

def delete_blob(bucket_name, blob_name):
    """Удаляет файл из указанного бакета."""
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(blob_name)
    blob.delete()

def upload_blob(bucket_name, source_file_name, destination_blob_name):
    """Загружает файл на Google Cloud Storage."""
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(destination_blob_name)
    blob.upload_from_filename(source_file_name)

def make_blob_public(bucket_name, blob_name):
    """Делает файл в GCS публично доступным."""
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(blob_name)
    blob.make_public()

def google_search(query):
    global EXTENDED_URL_LIST
    url = f"https://www.googleapis.com/customsearch/v1?q={query}&cx={SEARCH_ENGINE_ID}&key={API_KEY}"
    try:
        response = requests.get(url)
    except requests.exceptions.RequestException as e:
        print('Network error occurred:', e)
        return None

    if response:
        search_results = response.json()
        # Извлечение URL из результатов поиска
        urls = [item['link'] for item in search_results.get('items', [])[:10]]
        banned_urls = ["https://fra.europa.eu/sites/default/files/fra_uploads/handbook-law-asylum-migration-borders_ru.pdf", "https://www.exteriores.gob.es/Consulados/moscu/ru/ServiciosConsulares/Paginas/Consular/Condiciones-de-entrada-en-Espana.aspx", "https://www.gov.uk/guidance/support-for-family-members-of-british-nationals-in-ukraine-and-ukrainian-nationals-in-ukraine-and-the-uk.ru", "https://londonvisa.ru/coronavirus", "https://www.tourdom.ru/news/rossiyskie-turisty-mogut-vezzhat-bez-viz-v-12-stran-yuzhnoy-ameriki.html", "https://kasachstan.diplo.de/kz-ru/service/05-VisaEinreise", "https://www.uscis.gov/ru/Ukraine", "https://brazil.mfa.gov.by/ru/consular_issues/covid/"]
        
        for url_checker in urls:
            if "https://www.kdmid.ru/" in url_checker:
                urls.remove(url_checker)

        for banned_url in banned_urls:
            try:
                urls.remove(banned_url)
            except:
                None

        return urls
    else:
        return None
    
def parse_html(url, main_point, country):
    try:
        response = requests.get(url)
        html_content = response.text  # Используем текстовое содержимое ответа
    except requests.exceptions.RequestException as e:
        print('Network error occurred:', e)
        return None

    if html_content:
        paragraphs = key_words_parsing(main_point, html_content, country)
        return paragraphs
    else:
        return None

def key_words_parsing(key_word, html_content, country):
    global check
    global which_try
    soup = BeautifulSoup(html_content, 'html.parser')
    if key_word == "граница":
        if country == "Португалию":
            paragraphs = soup.find_all(class_="b-content__geo j-content__geo")[0].find_all('p')[2].get_text()
        else:
            paragraphs = soup.find_all(class_="b-content__geo j-content__geo")[0].find_all('p')[1].get_text()
    elif key_word == "виза":
        paragraphs = [p_tag.get_text() for p_tag in soup.find_all('p') if ((key_word in p_tag.get_text().lower() or "визы" 
                                                                            in p_tag.get_text().lower() or "визой" in p_tag.get_text().lower() or "визу" in p_tag.get_text().lower() or "визовый" in p_tag.get_text().lower()) 
                                                                            and ("пцр-тест" not in p_tag.get_text().lower() and "covid-19" not in p_tag.get_text().lower() and "ковид" not in p_tag.get_text().lower() and "ковидные" not in p_tag.get_text().lower() and "ковидом" not in p_tag.get_text().lower() and "пандемия" not in p_tag.get_text().lower() and "пандемией" not in p_tag.get_text().lower() and "пандемию" not in p_tag.get_text().lower() and "пцр-теста" not in p_tag.get_text().lower() and "промокоду" not in p_tag.get_text().lower() and "пандемии" not in p_tag.get_text().lower()) and p_tag.find_parent(class_="comment-text") is None)]
    elif key_word == "билеты":
        paragraphs = [p_tag.get_text() for p_tag in soup.find_all('p') if ((key_word in p_tag.get_text().lower() or "билет" 
                                                                            in p_tag.get_text().lower() or "билетом" in p_tag.get_text().lower() or "билетами" in p_tag.get_text().lower() or "рейсы" in p_tag.get_text().lower() or "рейсами" in p_tag.get_text().lower() or "рейс" in p_tag.get_text().lower() or "полет" in p_tag.get_text().lower() or "полёт" in p_tag.get_text().lower() or "полета" in p_tag.get_text().lower() or "полёта" in p_tag.get_text().lower() or "полеты" in p_tag.get_text().lower() or "полёты" in p_tag.get_text().lower()) 
                                                                            and ("пцр-тест" not in p_tag.get_text().lower() and "covid-19" not in p_tag.get_text().lower() and "ковид" not in p_tag.get_text().lower() and "ковидные" not in p_tag.get_text().lower() and "ковидом" not in p_tag.get_text().lower() and "пандемия" not in p_tag.get_text().lower() and "пандемией" not in p_tag.get_text().lower() and "пандемию" not in p_tag.get_text().lower() and "пцр-теста" not in p_tag.get_text().lower() and "промокоду" not in p_tag.get_text().lower() and "пандемии" not in p_tag.get_text().lower()) and p_tag.find_parent(class_="comment-text") is None)]
    elif key_word == "документы":
        paragraphs = [p_tag.get_text() for p_tag in soup.find_all('p') if ((key_word in p_tag.get_text().lower() or "документ" in p_tag.get_text().lower() or "загранпаспорт" in p_tag.get_text().lower() or "страховка" in p_tag.get_text().lower() or "страховку" in p_tag.get_text().lower() or "страховкой" in p_tag.get_text().lower() or "документами" in p_tag.get_text().lower() or "загранпаспортом" in p_tag.get_text().lower() or "страховки" in p_tag.get_text().lower()) and p_tag.find_parent(class_="comment-text") is None) and ("пцр-тест" not in p_tag.get_text().lower() and "covid-19" not in p_tag.get_text().lower() and "ковид" not in p_tag.get_text().lower() and "ковидные" not in p_tag.get_text().lower() and "ковидом" not in p_tag.get_text().lower() and "пандемия" not in p_tag.get_text().lower() and "пандемией" not in p_tag.get_text().lower() and "пандемию" not in p_tag.get_text().lower() and "пцр-теста" not in p_tag.get_text().lower() and "промокоду" not in p_tag.get_text().lower() and "пандемии" not in p_tag.get_text().lower())]
    
    if key_word == "граница":
        check = False
    else:
        if len(paragraphs) >=3 and which_try >= 2:
            check = False
    
    return paragraphs
        
def send_to_openai(paragraphs):
    messages = [
        {"role": "system", "content": "Вы являетесь помощником."},
        {"role": "user", "content": f"Сократи данный текст до одного абзаца. Важно, чтобы в нем присутствовала самая важная информация. Если текст слишком короткий, не пиши ничего лишнего и просто перефразируй."},
        {"role": "user", "content": "\n\n".join(paragraphs)}
    ]
    data = {
        "model": "gpt-4",
        "messages": messages,
        "max_tokens": 300
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
        "documents": ""
        }
        ]
    }

def insert_in_json(name_of_country, which_point, data):
    json_file.data["request"][0]["name"] = COUNTRIES_RUS_2[name_of_country]
    json_file.data["request"][0][MAIN_POINTS_ENG[which_point]] = data

for country in COUNTRIES_RUS_1:
    main(country)

print(gpt_calls_count)
