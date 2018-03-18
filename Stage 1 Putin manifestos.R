library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
library("quanteda")

# Choose necessary file
text <- readLines(file.choose())
docs <- Corpus(VectorSource(text))



inspect(docs)
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))

docs <- tm_map(docs, toSpace, "/")
#docs <- tm_map(docs, toSpace, "\")
docs <- tm_map(docs, toSpace, "—")
docs <- tm_map(docs, toSpace, "-")
docs <- tm_map(docs, toSpace, "–")

docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")
# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove russian common stopwords
docs <- tm_map(docs, removeWords, stopwords("russian"))
# Remove your own stop word
# specify your stopwords as a character vector
docs <- tm_map(docs, removeWords, c("российский", "сколько", "просто", "однако",
                                    "добрый", "день", "лицо", "лишь", "ваш", 
                                    "причём", "менее", "считаю", "вид", "иметь", 
                                    "самый", "смочь", "стать", "счёт", "должный", 
                                    "наш", "ха", "свой", "свой", "часто", "идти", 
                                    "часть", "весь", "уровень", "дать", "хотеть", 
                                    "людей", "ещё", "мочь", "своей", "стран", "года", 
                                    "лет", "таким", "хочу", "счет", "других", "также", 
                                    "числе", "пока", "является", "свои", "этих", "образом",
                                    "лет", "годы", "таких", "будут", "тех", "будет", "году",
                                    "год","наша", "наши", "эта", "раза", "прежде", "раза", 
                                    "нужно", "именно", "очень", "своих", "своим", "нашим", 
                                    "необходимо", "будем", "наших", "те", "такую", "нашей", 
                                    "я", "мой", "это", "должны", "должен", "должна", 
                                    "которая", "которые", "который", "россия", "страна", "нам")) 
# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)
docs <- unlist(docs, recursive = TRUE, use.names = TRUE)
text.tmp <- system2("/Users/aidarzinnatullin/Downloads/mystem", c("-c", "-l", "-d"), input = docs, stdout = TRUE)

text.tmp
# Then I just copy the text to cinvert in into txt. file format. 

