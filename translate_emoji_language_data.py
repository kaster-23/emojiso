
import pandas as pd
from googletrans import Translator  # Install with `pip install googletrans==4.0.0-rc1`

# Load your emoji CSV
df = pd.read_csv("emoji_data_enriched.csv")

# List of target languages (ISO 639-1 codes)
languages = ["es", "fr", "de", "it", "pt", "ja", "zh", "ko", "ru", "ar", "he"]

# Initialize translator
translator = Translator()

# Prepare translations
language_data = []

for index, row in df.iterrows():
    translations = {}
    for lang in languages:
        try:
            translated_name = translator.translate(row["name"], dest=lang).text
            translated_keywords = [translator.translate(k, dest=lang).text for k in row["keywords"].split(",")]
            translations[lang] = {
                "name": translated_name,
                "keywords": translated_keywords
            }
        except Exception as e:
            print(f"Error at row {index}, lang {lang}: {e}")
            continue
    language_data.append(translations)

# Add to DataFrame
df["language_data"] = language_data

# Save as new CSV
df.to_csv("emoji_translated.csv", index=False)
print("✅ Translated CSV saved as emoji_translated.csv")
