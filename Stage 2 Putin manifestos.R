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
# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)

docs_matrix <- TermDocumentMatrix(docs)
m <- as.matrix(docs_matrix)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)

head(d, 10)

wordcloud(words = d$word, freq = d$freq,scale = c(2, .2),  min.freq = 1,
          max.words=50, random.order=FALSE, rot.per=.35, 
          colors=brewer.pal(8, "Dark2"))


barplot(d[1:10,]$freq, las = 1, axes = T, names.arg = d[1:10,]$word,
        col = c("green", "red", "blue", "yellow", "orange", "lightblue", "lavender", "cornsilk", "lavender", "lightcyan"), main ="Официальная программа В.Путина перед выборами 2012 года",
        xlab = "Частота слов", horiz = T, cex.names = 0.4, cex.axis = 0.8, xlim= c(0,25))
