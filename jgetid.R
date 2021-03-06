jgetid <- function(id, sleep=1) {

  require("XML", quietly=TRUE, warn.conflicts=FALSE, character.only=TRUE)
  require("plyr", quietly=TRUE, warn.conflicts=FALSE, character.only=TRUE)
  # Final table with (eventually) all shows
  d.jpdy <- data.frame()

  # Temporary table which will hold single show's data
  d.temp <- as.data.frame(matrix(NA,nrow=3,ncol=7))
  colnames(d.temp) <- c("1","2","3","4","5","6","WebId")

  #THE PRE-GAME
  #Loop to determine which shows are tournaments
  #Also determines shows that have no data

  for (m in id) {
    cat("id:", m, "\n", file="kgetid.txt", append=TRUE)
    url <- paste0("http://www.j-archive.com/showgame.php?game_id=", m)
    if(sleep > 0) Sys.sleep(sleep)
    doc <- try(htmlParse(url, error = function(...){}))
    r <- xmlRoot(doc)
    tables <- getNodeSet(doc, "//table")
	# WebId 4364 Alex announces Battle of the Decades voting winners, game is
	#   a regular game
    if(is.na(xmlValue(r[[2]][[4]][[4]])) |
	  (regexpr("Championship",xmlValue(r[[2]][[4]][[4]]))[1] > -1) | 
	  (regexpr("Kids",xmlValue(r[[2]][[4]][[4]]))[1] > -1) | 
	  (regexpr("Back to School",xmlValue(r[[2]][[4]][[4]]))[1] > -1) | 
	  (regexpr("Teen",xmlValue(r[[2]][[4]][[4]]))[1] > -1) | 
 	  (regexpr("Tournament",xmlValue(r[[2]][[4]][[4]]))[1] > -1) |
 	  (regexpr("College",xmlValue(r[[2]][[4]][[4]]))[1] > -1) |
	  (regexpr("Missing",xmlValue(r[[2]][[4]][[4]]))[1] > -1) |
	  (regexpr("Celebrity",xmlValue(r[[2]][[4]][[4]]))[1] > -1) |
	  (regexpr("Super",xmlValue(r[[2]][[4]][[4]]))[1] > -1) |
	  (regexpr("IBM",xmlValue(r[[2]][[4]][[4]]))[1] > -1) |
	  (regexpr("Power Players",xmlValue(r[[2]][[4]][[4]]))[1] > -1) |
	  (regexpr("Million Dollar",xmlValue(r[[2]][[4]][[4]]))[1] > -1) |
	  (regexpr("All-Star",xmlValue(r[[2]][[4]][[4]]))[1] > -1) |
	  (regexpr("Greatest of All Time",xmlValue(r[[2]][[4]][[4]]))[1] > -1) |
	  (regexpr("Battle of the Decades",xmlValue(r[[2]][[4]][[4]]))[1] > -1 && m != 4364) |
	  (length(llply(tables,names)) < 100)) {
	    id <- id[-which(id == m)]
     }
  }
  id
}
