
library("dplyr", lib.loc="~/R/win-library/3.3")
library("tidyr", lib.loc="~/R/win-library/3.3")

refine_original <- read.csv("~/refine_original.csv")


refine_original$company<-gsub(pattern = "Phillips|phillips|phllips|phillps|phillipS|fillips|phlips", replacement = "philips", x=refine_original$company)

refine_original$company<-gsub(pattern = "Akzo|AKZO|akz0|ak zo", replacement = "akzo", x=refine_original$company)

refine_original$company<-gsub(pattern = "Van Houten|van Houten", replacement = "van houten", x=refine_original$company)

refine_original$company<-gsub(pattern = "unilver|Unilever", replacement = "unilever", x=refine_original$company)


refine_original<-separate(refine_original, Product.code...number, c("product_code", "product_number"), sep="-")


refine_original<-mutate(refine_original, product_category= ifelse(grepl("p", product_code), "Smartphone",
                                                                  ifelse(grepl("v", product_code), "TV",
                                                                         ifelse(grepl("x", product_code), "Laptop", "Tablet") )))

refine_original<-unite(refine_original, "full_address", address, city, country, sep = ",", remove = FALSE)

refine_original<-mutate(refine_original, company_philips = ifelse(company=="philips", "1", "0"))

refine_original<-mutate(refine_original, company_akzo = ifelse(company=="akzo", "1", "0"))

refine_original<-mutate(refine_original, company_van_houten = ifelse(company=="van houten", "1", "0"))

refine_original<-mutate(refine_original, company_unilever = ifelse(company=="unilever", "1", "0"))

refine_original<-mutate(refine_original, product_smartphone = ifelse(product_code=="p", "1", "0"))

refine_original<-mutate(refine_original, product_tv = ifelse(product_code=="v", "1", "0"))

refine_original<-mutate(refine_original, product_laptop = ifelse(product_code=="x", "1", "0"))

refine_original<-mutate(refine_original, product_tablet = ifelse(product_code=="q", "1", "0"))

write.csv(file = 'c:\\Users\\Danya\\Documents\\Foundations in Data Science\\Data Wranglin Exercise 1\\refine_clean.csv', x = refine_original)
