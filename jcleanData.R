"jcleanData"<-
function(df, dropPilot=TRUE, drop504=TRUE,
    drop4983=TRUE, drop5348=TRUE, drop6054=TRUE, drop6067=TRUE,
    dropBackToSchool=TRUE, dropGOAT=TRUE) {
	# WebId's 4983 5348 6054 6067 are incomplete shows on J Archive
    require("stringr", quietly=TRUE, warn.conflicts=FALSE, character.only=TRUE)
    # Nellis Air Force Base:
    indx <- which(df$City == "Nellis Air Force Base" &
        df$State == "Las Vegas")
    if(length(indx)) {
        df[indx, "City"] <- "Las Vegas"
        df[indx, "State"] <- "Nevada"
    }
    # State misspelled:
    indx <- which(df$State == "Vriginia")
    if(length(indx)) {
        df[indx, "State"] <- "Virginia"
    }
    indx <- which(df$State == "Nevade")
    if(length(indx)) {
        df[indx, "State"] <- "Nevada"
    }
    indx <- which(df$State == "Onio")
    if(length(indx)) {
        df[indx, "State"] <- "Ohio"
    }
    indx <- which(df$State == "Caifornia")
    if(length(indx)) {
        df[indx, "State"] <- "California"
    }
    indx <- which(df$State == "IL")
    if(length(indx)) {
        df[indx, "State"] <- "Illinois"
    }
    indx <- which(df$State == "Kenrucky")
    if(length(indx)) {
        df[indx, "State"] <- "Kentucky"
    }
    indx <- which(df$State == "New Nork")
    if(length(indx)) {
        df[indx, "State"] <- "New York"
    }
    indx <- which(df$State == "British Colombia")
    if(length(indx)) {
        df[indx, "State"] <- "British Columbia"
    }
    indx <- which(df$State == "British Colombia")
    if(length(indx)) {
        df[indx, "State"] <- "British Columbia"
    }
    indx <- which(df$State == "Ontario Canada")
    if(length(indx)) {
        df[indx, "State"] <- "Ontario, Canada"
    }
    # State is just Canada, add Province:
    indx <- which(df$City == "Toronto" & df$State == "Canada")
    if(length(indx)) {
                df[indx, "State"] <- "Ontario, Canada"
    }
    indx <- which(df$City == "Sault Ste. Marie" & df$State == "Canada")
    if(length(indx)) {
                df[indx, "State"] <- "Ontario, Canada"
    }
    indx <- which(df$City == "Ottawa" & df$State == "Canada")
    if(length(indx)) {
                df[indx, "State"] <- "Ontario, Canada"
    }
    indx <- which(df$City == "Guelph" & df$State == "Canada")
    if(length(indx)) {
                df[indx, "State"] <- "Ontario, Canada"
    }
    indx <- which(df$City == "Winnipeg" & df$State == "Canada")
    if(length(indx)) {
                df[indx, "State"] <- "Manitoba, Canada"
    }
    indx <- which(df$City == "Montreal" & df$State == "Canada")
    if(length(indx)) {
                df[indx, "State"] <- "Quebec, Canada"
    }
    indx <- which(df$City == "Vancouver" & df$State == "Canada")
    if(length(indx)) {
                df[indx, "State"] <- "British Columbia, Canada"
    }
    indx <- which(df$City == "West Vancouver" & df$State == "Canada")
    if(length(indx)) {
                df[indx, "State"] <- "British Columbia, Canada"
    }
    # Add Canada to Provinces:
    for(p in c("Alberta", "British Columbia", "Manitoba",
        "Northwest Territories", "Nova Scotia", "Ontario",
        "Prince Edward Island",
        "Quebec", "Saskatchewan", "Yukon Territory")) {
        indx <- which(df$State == p)
        if(length(indx)) {
            df[indx, "State"] <- paste0(p, ", Canada")
        }
    }
    indx <- which(df$State == "Trinidad and Tobago and now in New York")
    if(length(indx)) {
        df[indx, "State"] <- "New York"
    }
    indx <- which(df$State == "Easton Maryland")
    if(length(indx)) {
        df[indx, "State"] <- "Maryland"
        df[indx, "City"] <- "Easton"
    }
    # State guess
    indx <- which(df$State == "Hawaii[?]")
    if(length(indx)) {
        df[indx, "State"] <- "Hawaii"
    }
    # Yellowstone National Park
    indx <- which(df$State == "Wyoming and Montana")
    if(length(indx)) {
        df[indx, "State"] <- "Wyoming"
    }
    # New York Boroughs
    indx <- which(df$State == "The Bronx")
    if(length(indx)) {
        df[indx, "City"] <- "New York"
        df[indx, "State"] <- "New York"
    }
    indx <- which(df$City == "Bronx" & df$State == "New York")
    if(length(indx)) {
        df[indx, "City"] <- "New York"
        df[indx, "State"] <- "New York"
    }
    indx <- which(df$City == "Brooklyn" & df$State == "New York")
    if(length(indx)) {
        df[indx, "City"] <- "New York"
        df[indx, "State"] <- "New York"
    }
    indx <- which(df$City == "Manhattan" & df$State == "New York")
    if(length(indx)) {
        df[indx, "City"] <- "New York"
        df[indx, "State"] <- "New York"
    }
    indx <- which(df$City == "Queens" & df$State == "New York")
    if(length(indx)) {
        df[indx, "City"] <- "New York"
        df[indx, "State"] <- "New York"
    }
    indx <- which(df$City == "Staten Island" & df$State == "New York")
    if(length(indx)) {
        df[indx, "City"] <- "New York"
        df[indx, "State"] <- "New York"
    }
    # New York City
    indx <- which(df$State == "New York City" | df$City == "New York City")
    if(length(indx)) {
        df[indx, "City"] <- "New York"
        df[indx, "State"] <- "New York"
    }
    # West Hartford, no state:
    indx <- which(df$State == "West Hartford")
    if(length(indx)) {
        df[indx, "City"] <- "West Hartford"
        df[indx, "State"] <- "Connecticut"
    }
    # now stationed at ... state
    indx <- grep("now stationed ", df$State)
    if(length(indx)) {
        for(i in indx) {
            stateFirstCommaIndex <- regexpr(',', df$State[i])[1]
            df$State[i] <- substr(df$State[i], 1, stateFirstCommaIndex - 1)
        }
    }
    # now living in ...
    indx <- grep("now living", df$State)
    if(length(indx)) {
        for(i in indx) {
            nowIndex <- regexpr('now living in ', df$State[i])
            newCityState <- substr(df$State[i], nowIndex[1] +
                attr(nowIndex, "match.length"), nchar(df$State[i]))
            cityStateCommaIndex <- gregexpr(',', newCityState)
            if(cityStateCommaIndex[[1]][1] == -1) {
                df$City[i] <- NA
                df$State[i] <- newCityState
            } else {
                df$City[i] <- str_trim(substr(newCityState, 1,
                    cityStateCommaIndex[[1]][1]-1))
                df$State[i] <- str_trim(substr(newCityState,
                    cityStateCommaIndex[[1]][1]+1, nchar(df$State[i])))
            }
        }
    }
    indx <- grep('nurse and "Mr. Mom"', df$Occupation)
    if(length(indx)) {
        df$Occupation[indx] <- "Nurse"
    }
    indx <- grep('"Mr. Mom"', df$Occupation)
    if(length(indx)) {
                df$Occupation[indx] <- "Dad"
    }
    # Drop Back to School Week games with children
    # Occupation was their age.
    youthOccupation <- c("10-year-old", "11-year-old", "12-year-old",
        "eleven-year-old", "ten-year-old", "twelve-year-old")
    indx <- which(df$Occupation %in% youthOccupation)
    if(length(indx)) {
        df <- df[-indx, ]
    }
	# Above does not get all Back to School Week games (Sept, 2003)
	# Remove others based on WebId instead
	# Note that jgetid will now drop "Back to School" games 2018-04-15
	webIdBackToSchool <- c(5014, 5015, 5016, 5017, 3342)
	indx <- which(df$WebId %in% webIdBackToSchool)
    if(length(indx)) {
	    df <- df[-indx, ]
    }
    indx <- grep('Leslie "Lefty" Scott', df$Name)
    if(length(indx)) {
        df$Name[indx] <- "Leslie Scott"
    }
    if(dropGOAT) {
        indx <- grep("Greatest of All Time", df$Title)
        if(length(indx)) {
            df <- df[-indx, ]
        }
    }
    if(dropPilot) {
        indx <- grep("pilot", df$Title)
        if(length(indx)) {
            df <- df[-indx, ]
        }
    }
    if(drop504) {
        indx <- which(df$WebId == 504)
        if(length(indx)) {
            df <- df[-indx, ]
        }
    }
    if(drop4983) {
        indx <- which(df$WebId == 4983)
        if(length(indx)) {
            df <- df[-indx, ]
        }
    }
    if(drop5348) {
        indx <- which(df$WebId == 5348)
        if(length(indx)) {
            df <- df[-indx, ]
        }
    }
    if(drop6054) {
        indx <- which(df$WebId == 6054)
        if(length(indx)) {
            df <- df[-indx, ]
        }
    }
    if(drop6067) {
        indx <- which(df$WebId == 6067)
        if(length(indx)) {
            df <- df[-indx, ]
        }
    }
    # Names and Occupation mixed:
    NameMixed <- c(
        "John Kilby, an owner o",
        "Chris Falcinelli, an owner o",
        "Cathy Melocik, an editor fo", 
        "Brad Rodriguez, an assistant general manager o",
        "Beverly Jones, an attorney fo", 
        "Lori Hohenleitner, an executive director fo",
        "Saidi Chen, an attorney fo", 
        "Barbara Sheridan, an attorney and law clerk t",
        "Mark Leinwand, an attorney an", 
        "Patricia Kelvin, an editor o",
		"Bob Verini, an academic director fo",
		"Sally Hatfield, an English a",
		"Buzz Newberry, an owner o"
    )
    for(nm in NameMixed) {
        indx <- grep(nm, df$Name)
        if(length(indx)) {
            znm <- strsplit(df$Name[indx[1]], ",")
            df$Name[indx] <- znm[[1]][1]
            df$Occupation[indx] <- str_trim(paste(znm[[1]][2],
                df$Occupation[indx]))
        }
    }    
    # Fix names:
    indx <- which(names(df) == "num_times_on_show")
    if(length(indx)) {
        names(df)[indx] <- "NumTimesOnShow"
    }
    indx <- which(names(df) == "first_round_winnings")
    if(length(indx)) {
        names(df)[indx] <- "FirstRoundScore"
    }
    indx <- which(names(df) == "Winnings_2nd_Round")
    if(length(indx)) {
        names(df)[indx] <- "SecondRoundScore"
    }
    indx <- which(names(df) == "Final_Winnings")
    if(length(indx)) {
        names(df)[indx] <- "FinalScore"
    }
    indx <- which(names(df) == "n.Right")
    if(length(indx)) {
        names(df)[indx] <- "NumRight"
    }
    indx <- which(names(df) == "n.Wrong")
    if(length(indx)) {
            names(df)[indx] <- "NumWrong"
    }
    indx <- which(names(df) == "DD.Wrong")
    if(length(indx)) {
            names(df)[indx] <- "DDWrong"
    }
    indx <- which(names(df) == "DD.Right")
    if(length(indx)) {
            names(df)[indx] <- "DDRight"
    }
    df
}
