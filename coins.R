#Idéen

coin <- sample(1:2,1)
if (coin == 1){
  paste0("krone")
}else{
  paste0("plat")
}





library(jsonlite)
library(httr)
library(rvest)
library(telegram.bot)

# Telegram bot token
bot_token <- "YOUR_BOT_TOKEN"
bot <- Bot(token = bot_token)

# Chat ID (skal tilpasses til din egen chat ID)
chat_id <- "YOUR_CHAT_ID"

# Funktion til at håndtere beskeder
handle_message <- function(bot, update) {
  # Hent beskeden fra brugeren
  message_text <- tolower(update$message$text)
  
  # Hvis beskeden er "flip", udfør møntkast
  if (message_text == "flip") {
    coin <- sample(1:10, 1)
    
    if (coin > 5) {
      # Hvis mønten lander på "krone"
      bot$sendPhoto(chat_id = chat_id, 
                    photo = "YOUR_PATH_TO_TAILS.PNG", 
                    caption = "RESULT: TAILS")
    } else {
      # Hvis mønten lander på "plat"
      bot$sendPhoto(chat_id = chat_id, 
                    photo = "YOUR_PATH_TO_TAILS.PNG", 
                    caption = "RESULT: HEADS")
    }
  } else {
    # Hvis beskeden ikke er "flip"
    bot$sendMessage(chat_id = chat_id, 
                    text = "WHAT ARE YOU TALKING ABOUT? TRY SAYING 'flip' if you want me to flip a coin")
  }
}

# Initialiser en updater og tilføj handleren
updater <- Updater(token = bot_token)
updater <- updater + MessageHandler(handle_message)

# Start botten
updater$start_polling()
