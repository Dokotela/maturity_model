import '../content/content.dart';

final countryContent = Content.fromJson({
    "level": "country",
    "domains": [
        {
            "title": "",
            "groups": [
                {
                    "title": "Data Sources",
                    "subTitle": "Data collection mechanisms and technologies. Structured data refers to content that has a predefined structure and is normally classified and stored in a traditional relational database. Unstructured data refers to different types of content that that is not classified in a standard manner.",
                    "level1": "Data is not collected and some data is available from external estimations (international organizations)",
                    "level2": "Date is sometimes obtained from few sources, largely using paper-based methods, although a few simple electronic tools like spreadsheets may be used for some data sources.  Data frequently has limited utility because of quality or disaggregation issues. Some indicators definitions are defined but not easily accessible/shared.",
                    "level3": "Health data are routinely from key data sources. Data is collected electronically using a variety of tools like spreadsheets, databases and electronic client-based information systems.  Integration from different sources is often a manual process, and may be constrained by comparability issues.",
                    "level4": "Health data is derived routinely and timely form all key data sources. The country carries out proactive activities to improve data collection processes.  Some data is available in near-real time to support decision-making.",
                    "level5": "Data from multiple data source types incl. unstructured sources such as social media and various types of devices (IoT) are used in health analysis. Large data sets integrated from multiple sources are readily available for analysis to support decision making.",
                    "items": [
                        {
                            "text": "For each structured key data source, identify how often data is collected/updated.",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Individual health records  ",
                            "level1": "Not collected",
                            "level2": "Collected on demand or on an ad hoc basis as required.",
                            "level3": "Routinely collected based on a defined schedule.",
                            "level4": "Routinely collected, some data available real time to support decision-making.",
                            "level5": "Routinely collected and available real time",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Health service (production) records",
                            "level1": "Not collected",
                            "level2": "Collected on demand or on an ad hoc basis as required.",
                            "level3": "Routinely collected based on a defined schedule.",
                            "level4": "Routinely collected, some data available real time to support decision-making.",
                            "level5": "Routinely collected and available real time",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Public Health Surveillance ",
                            "level1": "Not collected",
                            "level2": "Collected on demand or on an ad hoc basis as required.",
                            "level3": "Routinely collected based on a defined schedule.",
                            "level4": "Routinely collected, some data available real time to support decision-making.",
                            "level5": "Routinely collected and available real time",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Health infrastructure and facilities information ",
                            "level1": "Not collected",
                            "level2": "Collected on demand or on an ad hoc basis as required.",
                            "level3": "Routinely collected based on a defined schedule.",
                            "level4": "Routinely collected, some data available real time to support decision-making.",
                            "level5": "Routinely collected and available real time",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Human resources information",
                            "level1": "Not collected",
                            "level2": "Collected on demand or on an ad hoc basis as required.",
                            "level3": "Routinely collected based on a defined schedule.",
                            "level4": "Routinely collected, some data available real time to support decision-making.",
                            "level5": "Routinely collected and available real time",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Materials and supplies information",
                            "level1": "Not collected",
                            "level2": "Collected on demand or on an ad hoc basis as required.",
                            "level3": "Routinely collected based on a defined schedule.",
                            "level4": "Routinely collected, some data available real time to support decision-making.",
                            "level5": "Routinely collected and available real time",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Financial information",
                            "level1": "Not collected",
                            "level2": "Collected on demand or on an ad hoc basis as required.",
                            "level3": "Routinely collected based on a defined schedule.",
                            "level4": "Routinely collected, some data available real time to support decision-making.",
                            "level5": "Routinely collected and available real time",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Population based surveys",
                            "level1": "Not collected",
                            "level2": "Collected on demand or on an ad hoc basis as required.",
                            "level3": "Routinely collected based on a defined schedule.",
                            "level4": "Routinely collected, some data available real time to support decision-making.",
                            "level5": "Routinely collected and available real time",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Civil registration and vital statistics (CRVS)",
                            "level1": "Not collected",
                            "level2": "Collected on demand or on an ad hoc basis as required.",
                            "level3": "Routinely collected based on a defined schedule.",
                            "level4": "Routinely collected, some data available real time to support decision-making.",
                            "level5": "Routinely collected and available real time",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Population census",
                            "level1": "Not collected",
                            "level2": "Collected on demand or on an ad hoc basis as required.",
                            "level3": "Routinely collected based on a defined schedule.",
                            "level4": "Routinely collected, some data available real time to support decision-making.",
                            "level5": "Routinely collected and available real time",
                            "runtimeType": "question"
                        },
                        {
                            "text": "For the country structured key data sources identify how data is collected (format):",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Individual health records  ",
                            "level1": "Not collected",
                            "level2": "Mostly paper-based with some electronic tools (e.g. spreadsheets) used.",
                            "level3": "All data is collected electronically, mostly using databases or other electronic client-based information systems.  Data integration from various sites is done manually.",
                            "level4": "All data is collected electronically into integrated data repositories from multiple sites for specific data sources. Some data is available in real or near-real time for decision-making (e.g. dashboards).",
                            "level5": "A data is collected e data sets integrated across multiple sources (e.g. acrsoss different data sources or different institutions, or sub-national and national levels). All relevant data is available in real or near-real time for decision-making (e.g. dashboards).",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Health service (production) records",
                            "level1": "Not collected",
                            "level2": "Mostly paper-based with some electronic tools (e.g. spreadsheets) used.",
                            "level3": "All data is collected electronically, mostly using databases or other electronic client-based information systems.  Data integration from various sites is done manually.",
                            "level4": "All data is collected electronically into integrated data repositories from multiple sites for specific data sources. Some data is available in real or near-real time for decision-making (e.g. dashboards).",
                            "level5": "A data is collected e data sets integrated across multiple sources ( different data sources or different institutions, or sub-national and national levels). All relevant data is available in real or near-real time for decision-making (e.g. dashboards).",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Public Health Surveillance ",
                            "level1": "Not collected",
                            "level2": "Mostly paper-based with some electronic tools (e.g. spreadsheets) used.",
                            "level3": "All data is collected electronically, mostly using databases or other electronic client-based information systems.  Data integration from various sites is done manually.",
                            "level4": "All data is collected electronically into integrated data repositories from multiple sites for specific data sources. Some data is available in real or near-real time for decision-making (e.g. dashboards).",
                            "level5": "A data is collected e data sets integrated across multiple sources ( different data sources or different institutions, or sub-national and national levels). All relevant data is available in real or near-real time for decision-making (e.g. dashboards).",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Health infrastructure and facilities information ",
                            "level1": "Not collected",
                            "level2": "Mostly paper-based with some electronic tools (e.g. spreadsheets) used.",
                            "level3": "All data is collected electronically, mostly using databases or other electronic client-based information systems.  Data integration from various sites is done manually.",
                            "level4": "All data is collected electronically into integrated data repositories from multiple sites for specific data sources. Some data is available in real or near-real time for decision-making (e.g. dashboards).",
                            "level5": "A data is collected e data sets integrated across multiple sources ( different data sources or different institutions, or sub-national and national levels). All relevant data is available in real or near-real time for decision-making (e.g. dashboards).",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Human resources information",
                            "level1": "Not collected",
                            "level2": "Mostly paper-based with some electronic tools (e.g. spreadsheets) used.",
                            "level3": "All data is collected electronically, mostly using databases or other electronic client-based information systems.  Data integration from various sites is done manually.",
                            "level4": "All data is collected electronically into integrated data repositories from multiple sites for specific data sources. Some data is available in real or near-real time for decision-making (e.g. dashboards).",
                            "level5": "A data is collected e data sets integrated across multiple sources ( different data sources or different institutions, or sub-national and national levels). All relevant data is available in real or near-real time for decision-making (e.g. dashboards).",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Materials and supplies information",
                            "level1": "Not collected",
                            "level2": "Mostly paper-based with some electronic tools (e.g. spreadsheets) used.",
                            "level3": "All data is collected electronically, mostly using databases or other electronic client-based information systems.  Data integration from various sites is done manually.",
                            "level4": "All data is collected electronically into integrated data repositories from multiple sites for specific data sources. Some data is available in real or near-real time for decision-making (e.g. dashboards).",
                            "level5": "A data is collected e data sets integrated across multiple sources ( different data sources or different institutions, or sub-national and national levels). All relevant data is available in real or near-real time for decision-making (e.g. dashboards).",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Financial information",
                            "level1": "Not collected",
                            "level2": "Mostly paper-based with some electronic tools (e.g. spreadsheets) used.",
                            "level3": "All data is collected electronically, mostly using databases or other electronic client-based information systems.  Data integration from various sites is done manually.",
                            "level4": "All data is collected electronically into integrated data repositories from multiple sites for specific data sources. Some data is available in real or near-real time for decision-making (e.g. dashboards).",
                            "level5": "A data is collected e data sets integrated across multiple sources ( different data sources or different institutions, or sub-national and national levels). All relevant data is available in real or near-real time for decision-making (e.g. dashboards).",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Population based surveys",
                            "level1": "Not collected",
                            "level2": "Mostly paper-based with some electronic tools (e.g. spreadsheets) used.",
                            "level3": "All data is collected electronically, mostly using databases or other electronic client-based information systems.  Data integration from various sites is done manually.",
                            "level4": "All data is collected electronically into integrated data repositories from multiple sites for specific data sources. Some data is available in real or near-real time for decision-making (e.g. dashboards).",
                            "level5": "A data is collected e data sets integrated across multiple sources ( different data sources or different institutions, or sub-national and national levels). All relevant data is available in real or near-real time for decision-making (e.g. dashboards).",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Civil registration and vital statistics (CRVS)",
                            "level1": "Not collected",
                            "level2": "Mostly paper-based with some electronic tools (e.g. spreadsheets) used.",
                            "level3": "All data is collected electronically, mostly using databases or other electronic client-based information systems.  Data integration from various sites is done manually.",
                            "level4": "All data is collected electronically into integrated data repositories from multiple sites for specific data sources. Some data is available in real or near-real time for decision-making (e.g. dashboards).",
                            "level5": "A data is collected e data sets integrated across multiple sources ( different data sources or different institutions, or sub-national and national levels). All relevant data is available in real or near-real time for decision-making (e.g. dashboards).",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Population census",
                            "level1": "Not collected",
                            "level2": "Mostly paper-based with some electronic tools (e.g. spreadsheets) used.",
                            "level3": "All data is collected electronically, mostly using databases or other electronic client-based information systems.  Data integration from various sites is done manually.",
                            "level4": "All data is collected electronically into integrated data repositories from multiple sites for specific data sources. Some data is available in real or near-real time for decision-making (e.g. dashboards).",
                            "level5": "A data is collected e data sets integrated across multiple sources ( different data sources or different institutions, or sub-national and national levels). All relevant data is available in real or near-real time for decision-making (e.g. dashboards).",
                            "runtimeType": "question"
                        },
                        {
                            "text": "For each data source, disaggregation is available for the following variables (dimensions for equity measurement):",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Individual health records  ",
                            "level1": "Not collected",
                            "level2": "Sex, age by range",
                            "level3": "Sex, age by range, subnational location",
                            "level4": "Age by birth date, sex, subnational location, income level, education level",
                            "level5": "Age by birth date, sex, subnational location, income level, education level and other equity characteristic relevant to country (e.g. ethnicity, migration status, disability, sexual identity, etc.)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Public Health Surveillance ",
                            "level1": "Not collected",
                            "level2": "Sex, age by range",
                            "level3": "Sex, age by range, subnational location",
                            "level4": "Age by birth date, sex, subnational location, income level, education level",
                            "level5": "Age by birth date, sex, subnational location, income level, education level and other equity characteristic relevant to country (e.g. ethnicity, migration status, disability, sexual identity, etc.)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Human resources information",
                            "level1": "Not collected",
                            "level2": "Sex, age by range",
                            "level3": "Sex, age by range, subnational location",
                            "level4": "Age by birth date, sex, subnational location, income level, education level",
                            "level5": "Age by birth date, sex, subnational location, income level, education level and other equity characteristic relevant to country (e.g. ethnicity, migration status, disability, sexual identity, etc.)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Population based surveys",
                            "level1": "Not collected",
                            "level2": "Sex, age by range",
                            "level3": "Sex, age by range, subnational location",
                            "level4": "Age by birth date, sex, subnational location, income level, education level",
                            "level5": "Age by birth date, sex, subnational location, income level, education level and other equity characteristic relevant to country (e.g. ethnicity, migration status, disability, sexual identity, etc.)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Civil registration and vital statistics (CRVS)",
                            "level1": "Not collected",
                            "level2": "Sex, age by range",
                            "level3": "Sex, age by range, subnational location",
                            "level4": "Age by birth date, sex, subnational location, income level, education level",
                            "level5": "Age by birth date, sex, subnational location, income level, education level and other equity characteristic relevant to country (e.g. ethnicity, migration status, disability, sexual identity, etc.)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Population census",
                            "level1": "Not collected",
                            "level2": "Sex, age by range",
                            "level3": "Sex, age by range, subnational location",
                            "level4": "Age by birth date, sex, subnational location, income level, education level",
                            "level5": "Age by birth date, sex, subnational location, income level, education level and other equity characteristic relevant to country (e.g. ethnicity, migration status, disability, sexual identity, etc.)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "For each data source: Data quality of variables are good quality (completeness and accurate). ",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Individual health records  ",
                            "level1": "Not collected",
                            "level2": "Data is collected, but often cannot be used due to completeness and accuracy problems.",
                            "level3": "The are known completeness and accuracy problems for some data elements.  Data from different sources are often not comparable due to quality issues.",
                            "level4": "Data is generally reliable complete and accurate for all data elements for at least 5 years. Biases/issues are known and analyses can be accordingly adjusted.  Data is comparable across sources and time.",
                            "level5": "Data is reliably complete and accurate for at least 10 years.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Health service (production) records",
                            "level1": "Not collected",
                            "level2": "Data is collected, but often cannot be used due to completeness and accuracy problems.",
                            "level3": "The are known completeness and accuracy problems for some data elements.  Data from different sources are often not comparable due to quality issues.",
                            "level4": "Data is generally reliable complete and accurate for all data elements for at least two years. Biases/issues are known and analyses can be accordingly adjusted.  Data is comparable across sources and time.",
                            "level5": "Data is reliably complete and accurate for at least five years.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Surveillance ",
                            "level1": "Not collected",
                            "level2": "Data is collected, but often cannot be used due to completeness and accuracy problems.",
                            "level3": "The are known completeness and accuracy problems for some data elements.  Data from different sources are often not comparable due to quality issues.",
                            "level4": "Data is generally reliable complete and accurate for all data elements for at least two years. Biases/issues are known and analyses can be accordingly adjusted.  Data is comparable across sources and time.",
                            "level5": "Data is reliably complete and accurate for at least five years.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Health infrastructure and facilities information ",
                            "level1": "Not collected",
                            "level2": "Data is collected, but often cannot be used due to completeness and accuracy problems.",
                            "level3": "The are known completeness and accuracy problems for some data elements.  Data from different sources are often not comparable due to quality issues.",
                            "level4": "Data is generally reliable complete and accurate for all data elements for at least two years. Biases/issues are known and analyses can be accordingly adjusted.  Data is comparable across sources and time.",
                            "level5": "Data is reliably complete and accurate for at least five years.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Human resources information",
                            "level1": "Not collected",
                            "level2": "Data is collected, but often cannot be used due to completeness and accuracy problems.",
                            "level3": "The are known completeness and accuracy problems for some data elements.  Data from different sources are often not comparable due to quality issues.",
                            "level4": "Data is generally reliable complete and accurate for all data elements for at least two years. Biases/issues are known and analyses can be accordingly adjusted.  Data is comparable across sources and time.",
                            "level5": "Data is reliably complete and accurate for at least five years.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Materials and supplies information",
                            "level1": "Not collected",
                            "level2": "Data is collected, but often cannot be used due to completeness and accuracy problems.",
                            "level3": "The are known completeness and accuracy problems for some data elements.  Data from different sources are often not comparable due to quality issues.",
                            "level4": "Data is generally reliable complete and accurate for all data elements for at least two years. Biases/issues are known and analyses can be accordingly adjusted.  Data is comparable across sources and time.",
                            "level5": "Data is reliably complete and accurate for at least five years.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Financial information",
                            "level1": "Not collected",
                            "level2": "Data is collected, but often cannot be used due to completeness and accuracy problems.",
                            "level3": "The are known completeness and accuracy problems for some data elements.  Data from different sources are often not comparable due to quality issues.",
                            "level4": "Data is generally reliable complete and accurate for all data elements for at least two years. Biases/issues are known and analyses can be accordingly adjusted.  Data is comparable across sources and time.",
                            "level5": "Data is reliably complete and accurate for at least five years.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Population based surveys",
                            "level1": "Not collected",
                            "level2": "Data is collected, but often cannot be used due to completeness and accuracy problems.",
                            "level3": "The are known completeness and accuracy problems for some data elements.  Data from different sources are often not comparable due to quality issues.",
                            "level4": "Data is generally reliable complete and accurate for all data elements for at least two years. Biases/issues are known and analyses can be accordingly adjusted.  Data is comparable across sources and time.",
                            "level5": "Data is reliably complete and accurate for at least five years.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Civil registration and vital statistics (CRVS)",
                            "level1": "Not collected",
                            "level2": "Data is collected, but often cannot be used due to completeness and accuracy problems.",
                            "level3": "The are known completeness and accuracy problems for some data elements.  Data from different sources are often not comparable due to quality issues.",
                            "level4": "Data is generally reliable complete and accurate for all data elements for at least two years. Biases/issues are known and analyses can be accordingly adjusted.  Data is comparable across sources and time.",
                            "level5": "Data is reliably complete and accurate for at least five years.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Population census",
                            "level1": "Not collected",
                            "level2": "Data is collected, but often cannot be used due to completeness and accuracy problems.",
                            "level3": "The are known completeness and accuracy problems for some data elements.  Data from different sources are often not comparable due to quality issues.",
                            "level4": "Data is generally reliable complete and accurate for all data elements for at least two years. Biases/issues are known and analyses can be accordingly adjusted.  Data is comparable across sources and time.",
                            "level5": "Data is reliably complete and accurate for at least five years.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "National Health Accounts data is available.",
                            "level1": "Health expenditure data relies on external estimations from international organizations.",
                            "level2": "Health expenditure data relies on survey estimates and ad hoc studies.",
                            "level3": "There is at least 1 year of collection and classification of health expenditure data using the SHA 2011 system.",
                            "level4": "There is a time series of health accounts data (SHA 2011) for at least 3 years.",
                            "level5": "There is a system of national health accounts that produces annual health expenditure data, monitors health system performance and benchmarks health care spending. The government has established a health accounts team.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Information Products::Health data that are processed and published openly in a variety of formats that accomplish the different needs of IS4H constituencies.",
                            "level1": "Indicator are not generally produced by the national health authorities.  Indicators rely heavily on estimates from international organizations.",
                            "level2": "Some information products are generated, but not routinely, require intensive work and use of resources. Data is not readily shared across units, with stakeholders or public. Sharing data frequently requires permission from senior levels.  Indicators generation largely relies on data from survey's, census, and other ad hoc studies.",
                            "level3": "A range information products are efficiently and routinely produced from varies country information systems that may complement each other.  Dissemination of information products is typically limited to senior-level decision makers.",
                            "level4": "Information products are routinely produced that meet the specific needs of various stakeholders, and are routinely distributed to stakeholders at all levels of the health system.",
                            "level5": "Information products are developed from a range of structured and unstructured data sources. Data for decision-making is available in near real time to all stakeholders",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Data sources for key health indicators:   ",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Cause of Death Data",
                            "level1": "International estimations",
                            "level2": "Survey, census, ad hoc studies",
                            "level3": "Mix of sources ",
                            "level4": "Country specific information systems",
                            "level5": "integrated national information system (CVRS)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Maternal Mortality",
                            "level1": "International estimations",
                            "level2": "Survey, census, ad hoc studies",
                            "level3": "Mix of sources ",
                            "level4": "Country specific information systems",
                            "level5": "integrated national information system (CVRS)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "(Cancer incidence, fasting blood glucose-diabetes) Non Communicable Diseases",
                            "level1": "International estimations",
                            "level2": "Survey, ad hoc studies",
                            "level3": "Mix of sources ",
                            "level4": "Country specific information systems",
                            "level5": "integrated national information system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Malaria, Dengue (communicable diseases)",
                            "level1": "International estimations",
                            "level2": "Ad hoc studies",
                            "level3": "Mix of sources ",
                            "level4": "Country specific information systems",
                            "level5": "integrated national information system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "HIV - TB (communicable diseases)",
                            "level1": "International estimations",
                            "level2": "Ad hoc studies",
                            "level3": "Mix of sources ",
                            "level4": "Country specific information systems",
                            "level5": "integrated national information system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Disability statistics",
                            "level1": "International estimations",
                            "level2": "Survey, census, ad hoc studies",
                            "level3": "Mix of sources ",
                            "level4": "Country specific information systems",
                            "level5": "integrated national information system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Vaccine preventable diseases and Immunization coverage",
                            "level1": "International estimations",
                            "level2": "Survey, census, ad hoc studies",
                            "level3": "Mix of sources ",
                            "level4": "Country specific information systems",
                            "level5": "integrated national information system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Overweight and obesity (Risk Factors)",
                            "level1": "International estimations",
                            "level2": "Survey, census, ad hoc studies",
                            "level3": "Mix of sources ",
                            "level4": "Country specific information systems",
                            "level5": "integrated national information system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Physicians, Nurses, Dentists (Health Systems)",
                            "level1": "International estimations",
                            "level2": "Survey, census, ad hoc studies",
                            "level3": "Mix of sources ",
                            "level4": "Country specific information systems",
                            "level5": "integrated national information system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Indicator and event-based surveillance system in  place based on IHR standards",
                            "level1": "None",
                            "level2": "Planned",
                            "level3": "Indicator or event based system in place",
                            "level4": "In place",
                            "level5": "In place and support other countries with expertise",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Frequency of indicator reporting ",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Cause of Death Data",
                            "level1": "Never",
                            "level2": "On demand/ad hoc",
                            "level3": "Most indicators routinely reported on defined schedule",
                            "level4": "All indicators routinely available on a defined schedule",
                            "level5": "Indicators are always available with current data.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Maternal Mortality",
                            "level1": "Never",
                            "level2": "On demand/ad hoc",
                            "level3": "Most indicators routinely reported on defined schedule",
                            "level4": "All indicators routinely available on a defined schedule",
                            "level5": "Indicators are always available with current data.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Neonatal Mortality",
                            "level1": "Never",
                            "level2": "On demand/ad hoc",
                            "level3": "Most indicators routinely reported on defined schedule",
                            "level4": "All indicators routinely available on a defined schedule",
                            "level5": "Indicators are always available with current data.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "(Cancer incidence, fasting blood glucose-diabetes) Non Communicable Diseases",
                            "level1": "Never",
                            "level2": "On demand/ad hoc",
                            "level3": "Most indicators routinely reported on defined schedule",
                            "level4": "All indicators routinely available on a defined schedule",
                            "level5": "Indicators are always available with current data.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Malaria, Dengue (communicable diseases)",
                            "level1": "Never",
                            "level2": "On demand/ad hoc",
                            "level3": "Most indicators routinely reported on defined schedule",
                            "level4": "All indicators routinely available on a defined schedule",
                            "level5": "Indicators are always available with current data.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "HIV - TB (communicable diseases)",
                            "level1": "Never",
                            "level2": "On demand/ad hoc",
                            "level3": "Most indicators routinely reported on defined schedule",
                            "level4": "All indicators routinely available on a defined schedule",
                            "level5": "Indicators are always available with current data.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Disability statistics",
                            "level1": "Never",
                            "level2": "On demand/ad hoc",
                            "level3": "Most indicators routinely reported on defined schedule",
                            "level4": "All indicators routinely available on a defined schedule",
                            "level5": "Indicators are always available with current data.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Vaccine preventable diseases and Immunization coverage",
                            "level1": "Never",
                            "level2": "On demand/ad hoc",
                            "level3": "Most indicators routinely reported on defined schedule",
                            "level4": "All indicators routinely available on a defined schedule",
                            "level5": "Indicators are always available with current data.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Overweight and obesity (Risk Factors)",
                            "level1": "Never",
                            "level2": "On demand/ad hoc",
                            "level3": "Most indicators routinely reported on defined schedule",
                            "level4": "All indicators routinely available on a defined schedule",
                            "level5": "Indicators are always available with current data.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Physicians, Nurses, Dentists (Health Systems)",
                            "level1": "Never",
                            "level2": "On demand/ad hoc",
                            "level3": "Most indicators routinely reported on defined schedule",
                            "level4": "All indicators routinely available on a defined schedule",
                            "level5": "Indicators are always available with current data.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Access and dissemination of indicators",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Cause of Death Data",
                            "level1": "No dissemination",
                            "level2": "Upon request",
                            "level3": "Disseminated to senior authorities ",
                            "level4": "Disseminated to stakeholders throughout the health system",
                            "level5": "Publicly available",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Maternal Mortality",
                            "level1": "No dissemination",
                            "level2": "Upon request",
                            "level3": "Disseminated to senior authorities ",
                            "level4": "Disseminated to stakeholders throughout the health system",
                            "level5": "Publicly available",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Neonatal Mortality",
                            "level1": "No dissemination",
                            "level2": "Upon request",
                            "level3": "Disseminated to senior authorities ",
                            "level4": "Disseminated to stakeholders throughout the health system",
                            "level5": "Publicly available",
                            "runtimeType": "question"
                        },
                        {
                            "text": "(Cancer incidence, fasting blood glucose-diabetes) Non Communicable Diseases",
                            "level1": "No dissemination",
                            "level2": "Upon request",
                            "level3": "Disseminated to senior authorities ",
                            "level4": "Disseminated to stakeholders throughout the health system",
                            "level5": "Publicly available",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Maleria, Dengue (communicable diseases)",
                            "level1": "No dissemination",
                            "level2": "Upon request",
                            "level3": "Disseminated to senior authorities ",
                            "level4": "Disseminated to stakeholders throughout the health system",
                            "level5": "Publicly available",
                            "runtimeType": "question"
                        },
                        {
                            "text": "HIV - TB (communicable diseases)",
                            "level1": "No dissemination",
                            "level2": "Upon request",
                            "level3": "Disseminated to senior authorities ",
                            "level4": "Disseminated to stakeholders throughout the health system",
                            "level5": "Publicly available",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Disability statistics",
                            "level1": "No dissemination",
                            "level2": "Upon request",
                            "level3": "Disseminated to senior authorities ",
                            "level4": "Disseminated to stakeholders throughout the health system",
                            "level5": "Publicly available",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Vaccine preventable diseases and Immunization coverage",
                            "level1": "No dissemination",
                            "level2": "Upon request",
                            "level3": "Disseminated to senior authorities ",
                            "level4": "Disseminated to stakeholders throughout the health system",
                            "level5": "Publicly available",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Overweight and obesity (Risk Factors)",
                            "level1": "No dissemination",
                            "level2": "Upon request",
                            "level3": "Disseminated to senior authorities ",
                            "level4": "Disseminated to stakeholders throughout the health system",
                            "level5": "Publicly available",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Physicians, Nurses, Dentists (Health Systems)",
                            "level1": "No dissemination",
                            "level2": "Upon request",
                            "level3": "Disseminated to senior authorities ",
                            "level4": "Disseminated to stakeholders throughout the health system",
                            "level5": "Publicly available",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Availability of census results",
                            "level1": "No results are available ",
                            "level2": "Only final results available in paper-based formats",
                            "level3": "Final results available online",
                            "level4": "Preliminary and final results available online",
                            "level5": "A release calendar for population census results is published and all  results online",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Availability of population health survey results",
                            "level1": "No results are available ",
                            "level2": "Only final results available in paper-based formats",
                            "level3": "Final results available online",
                            "level4": "Preliminary and final results available online",
                            "level5": "A release calendar for population survey results is published and all  results online",
                            "runtimeType": "question"
                        },
                        {
                            "text": "National Health Observatory is available",
                            "level1": "No",
                            "level2": "An institutional platform is in development but not operational",
                            "level3": "An institutional platform exists and updated less than annually and with limited content of indicators",
                            "level4": "An institutional platform is updated frequently with extensive coverage of health statistics",
                            "level5": "A national platform is updated frequently with full coverage of health statistics and open access",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Frequency of selected information products",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "National core health indicators (incl SDG)",
                            "level1": "Never",
                            "level2": "Yes, but rarely",
                            "level3": "Ad hoc basis",
                            "level4": "Frequently, but with no defined schedule",
                            "level5": "Routinely on a defined schedule",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Epidemiological bulletins",
                            "level1": "Never",
                            "level2": "Yes, but rarely",
                            "level3": "Ad hoc basis",
                            "level4": "Frequently, but with no defined schedule",
                            "level5": "Routinely on a defined schedule",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Conference presentations",
                            "level1": "Never",
                            "level2": "Yes, but rarely",
                            "level3": "Ad hoc basis",
                            "level4": "Frequently, but with no defined schedule",
                            "level5": "Routinely on a defined schedule",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Academic papers",
                            "level1": "Never",
                            "level2": "Yes, but rarely",
                            "level3": "Ad hoc basis",
                            "level4": "Frequently, but with no defined schedule",
                            "level5": "Routinely on a defined schedule",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Management reports",
                            "level1": "Never",
                            "level2": "Yes, but rarely",
                            "level3": "Ad hoc basis",
                            "level4": "Frequently, but with no defined schedule",
                            "level5": "Routinely on a defined schedule",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Guidelines/protocols (evidence informed)",
                            "level1": "Never",
                            "level2": "Yes, but rarely",
                            "level3": "Ad hoc basis",
                            "level4": "Frequently, but with no defined schedule",
                            "level5": "Routinely on a defined schedule",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Policy briefs (evidence informed)",
                            "level1": "Never",
                            "level2": "Yes, but rarely",
                            "level3": "Ad hoc basis",
                            "level4": "Frequently, but with no defined schedule",
                            "level5": "Routinely on a defined schedule",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Annual Reports (e.g. program reports, CMO’s report)",
                            "level1": "Never",
                            "level2": "Yes, but rarely",
                            "level3": "Ad hoc basis",
                            "level4": "Frequently, but with no defined schedule",
                            "level5": "Routinely on a defined schedule",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Health Situation Analysis",
                            "level1": "Never",
                            "level2": "Yes, but rarely",
                            "level3": "Ad hoc basis",
                            "level4": "Frequently, but with no defined schedule",
                            "level5": "Routinely on a defined schedule",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Media releases (evidence informed)",
                            "level1": "Never",
                            "level2": "Yes, but rarely",
                            "level3": "Ad hoc basis",
                            "level4": "Frequently, but with no defined schedule",
                            "level5": "Routinely on a defined schedule",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Social media (evidence informed)",
                            "level1": "Never",
                            "level2": "Yes, but rarely",
                            "level3": "Ad hoc basis",
                            "level4": "Frequently, but with no defined schedule",
                            "level5": "Routinely on a defined schedule",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Data standards",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "WHO International Classification Family (e.g. ICD-9/10/11, ICPC, ICF)",
                            "level1": "No awareness or plans to adopt.",
                            "level2": "There is general awareness of the standards, but no plans to adopt.",
                            "level3": "Identified as a standards, with a formal plan for adoption",
                            "level4": "Formally defined and adopted nationally. ",
                            "level5": "Fully implemented nationally",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Clinical Procedural Terminology (CPT)",
                            "level1": "No awareness or plans to adopt.",
                            "level2": "There is general awareness of the standards, but no plans to adopt.",
                            "level3": "Identified as a standards, with a formal plan for adoption",
                            "level4": "Formally defined and adopted nationally. ",
                            "level5": "Fully implemented nationally",
                            "runtimeType": "question"
                        },
                        {
                            "text": " Laboratory data standards (e.g.) LOINC",
                            "level1": "No awareness or plans to adopt.",
                            "level2": "There is general awareness of the standards, but no plans to adopt.",
                            "level3": "Identified as a standards, with a formal plan for adoption",
                            "level4": "Formally defined and adopted nationally. ",
                            "level5": "Fully implemented nationally",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Pharmacy data standards (e.g., National Drug Codes)",
                            "level1": "No awareness or plans to adopt.",
                            "level2": "There is general awareness of the standards, but no plans to adopt.",
                            "level3": "Identified as a standards, with a formal plan for adoption",
                            "level4": "Formally defined and adopted nationally. ",
                            "level5": "Fully implemented nationally",
                            "runtimeType": "question"
                        },
                        {
                            "text": "National Core Data Standards (data dictionary)",
                            "level1": "No awareness or plans to adopt.",
                            "level2": "There is general awareness of the standards, but no plans to adopt.",
                            "level3": "Identified as a standards, with a formal plan for adoption",
                            "level4": "Formally defined and adopted nationally. ",
                            "level5": "Fully implemented nationally",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Messaging standards",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "HL7",
                            "level1": "No awareness or plans to adopt.",
                            "level2": "There is general awareness of the standards, but no plans to adopt.",
                            "level3": "Identified as a standards, with a formal plan for adoption",
                            "level4": "Formally defined and adopted nationally. ",
                            "level5": "Fully implemented nationally",
                            "runtimeType": "question"
                        },
                        {
                            "text": "FHIR",
                            "level1": "No awareness or plans to adopt.",
                            "level2": "There is general awareness of the standards, but no plans to adopt.",
                            "level3": "Identified as a standards, with a formal plan for adoption",
                            "level4": "Formally defined and adopted nationally. ",
                            "level5": "Fully implemented nationally",
                            "runtimeType": "question"
                        },
                        {
                            "text": "DICOM",
                            "level1": "No awareness or plans to adopt.",
                            "level2": "There is general awareness of the standards, but no plans to adopt.",
                            "level3": "Identified as a standards, with a formal plan for adoption",
                            "level4": "Formally defined and adopted nationally. ",
                            "level5": "Fully implemented nationally",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Content standards",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "SNOMED-CT",
                            "level1": "No awareness or plans to adopt.",
                            "level2": "There is general awareness of the standards, but no plans to adopt.",
                            "level3": "Identified as a standards, with a formal plan for adoption",
                            "level4": "Formally defined and adopted nationally. ",
                            "level5": "Fully implemented nationally",
                            "runtimeType": "question"
                        },
                        {
                            "text": "CDA (Clinical Document Architecture)",
                            "level1": "No awareness or plans to adopt.",
                            "level2": "There is general awareness of the standards, but no plans to adopt.",
                            "level3": "Identified as a standards, with a formal plan for adoption",
                            "level4": "Formally defined and adopted nationally. ",
                            "level5": "Fully implemented nationally",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Common data model implemented",
                            "level1": "No awareness or plans to adopt.",
                            "level2": "There is general awareness , but no plans to adopt.",
                            "level3": "Defined and implemented for some sources",
                            "level4": "Formally defined and adopted nationally. ",
                            "level5": "Fully implemented nationally",
                            "runtimeType": "question"
                        },
                        {
                            "text": "A set of national core health indicators including definitions and metadata exists",
                            "level1": "No awareness or plans to adopt.",
                            "level2": "There is general awareness , but no plans to adopt.",
                            "level3": "Defined and implemented for some sources",
                            "level4": "Formally defined and adopted nationally. ",
                            "level5": "Fully implemented nationally",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Definitions and metadata for a the Sustainable Development Goals (SDGs)",
                            "level1": "No plans to adopt.",
                            "level2": "There is general awareness but no plans to dedicate resources to monitor SDG",
                            "level3": "Defined and implemented to monitor some SDG ",
                            "level4": "Formally defined SDG set of indicators and adopted nationally. In process to indicators that are currently not being collected. Expansion of   disaggregated data.",
                            "level5": "A national set of SDG - tailored to country priorities - fully adopted and monitored, including disaggregation",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Unique identifier and identity management",
                            "level1": "None",
                            "level2": "Unique identifiers at the facilities not unique to the individual, but no identity management.",
                            "level3": "Unique identifier at the facility level with identity management",
                            "level4": "Unique identifier for the public health system, converging with identifiers at the health facilities",
                            "level5": "Unique identifier at the national level",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There is a national health information architecture ",
                            "level1": "None",
                            "level2": "Key data sources and data flows are mapped",
                            "level3": "Data sources, data flows, data repositories, messaging and data standards documented within the public health system",
                            "level4": "Data sources, data flows,  data repositories, messaging and data standards documented and partially implemented within the national health system",
                            "level5": "National health information architecture fully implemented",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Data Governance::Health data governance is the framework for establishing sub-regional and national strategies, objectives, policies, standards, and tools for the management of technical data, which is supported by a legal framework.",
                            "level1": "There a few if any best practices for data management implemented.  Data management is largely ad hoc.  There are no formal mechanisms for decisions about data quality and standards.",
                            "level2": "Data management best practices are in development, but not fully implemented.  Data quality is not routinely monitored.  Decision about standards quality and standards are made at the facility/unit/team level.",
                            "level3": "Data management processes and best practices are implemented for some facilities/units/teams.  (e.g. Data quality frameworks, data standards, policies, SOPs,…) Core sets are readily available. Data are rarely integrated for analysis across various sources. Some metadata are documented and maintained (indicator compendium, data dictionaries). A data governance body within the national health authority exists.",
                            "level4": "A formal health data governance mechanisms has been established at the national level with other health data stakeholders, and there are processes and plan in place to strengthen alignment of standards, data quality frameworks and data management practices across all stakeholders. ",
                            "level5": "Data management policies, procedures and best practices are consistently applied, resulting in availability of quality data. Formal data governance mechanisms (committees, policies, data quality frameworks, data sharing agreements etc.) have been established among national health stakeholders, including private sector, are effectively functioning. Continuous improvement processes established to monitor and invest in data quality.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There is a formal data governance body that makes decisions about data quality, standards and investments.",
                            "level1": "There are no formal mechanism for making decisions about data.",
                            "level2": "Decision about data are made within the facility/unit/team. ",
                            "level3": "The national health authority has established a formal body for making decisions about data",
                            "level4": "There is a national body that makes decisions about health data that meets and works across sectors including part of private sector",
                            "level5": "There is a national body that make decisions about data and that functions and works across sectors including the private sector",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There is a data quality framework in place.",
                            "level1": "No framework",
                            "level2": "Some facilities/units/teams work on data quality but no data quality framework exists.",
                            "level3": "There is a data quality framework for the national health authorities.",
                            "level4": "There is a data quality framework that is shared or aligned between national health authorities and some key multisectoral stakeholders",
                            "level5": "There is a data quality framework that is aligned and fully implemented at the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There are defined SOPs for data management (data collection, aggregation, cleansing, store and archiving, etc.)",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Cause of Death Data",
                            "level1": "No",
                            "level2": "Defined for facilities/units/teams, but not formally implemented",
                            "level3": "Fully implemented in some facilities/units/teams",
                            "level4": "Fully implemented and aligned across national health authorities",
                            "level5": "Yes, fully implemented at the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Maternal Mortality",
                            "level1": "No",
                            "level2": "Defined for facilities/units/teams, but not formally implemented",
                            "level3": "Fully implemented in some facilities/units/teams",
                            "level4": "Fully implemented and aligned across national health authorities",
                            "level5": "Yes, fully implemented at the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "(Cancer incidence, fasting blood glucose-diabetes) Non Communicable Diseases",
                            "level1": "No",
                            "level2": "Defined for facilities/units/teams, but not formally implemented",
                            "level3": "Fully implemented in some facilities/units/teams",
                            "level4": "Fully implemented and aligned across national health authorities",
                            "level5": "Yes, fully implemented at the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Malaria, Dengue (communicable diseases)",
                            "level1": "No",
                            "level2": "Defined for facilities/units/teams, but not formally implemented",
                            "level3": "Fully implemented in some facilities/units/teams",
                            "level4": "Fully implemented and aligned across national health authorities",
                            "level5": "Yes, fully implemented at the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "HIV - TB (communicable diseases)",
                            "level1": "No",
                            "level2": "Defined for facilities/units/teams, but not formally implemented",
                            "level3": "Fully implemented in some facilities/units/teams",
                            "level4": "Fully implemented and aligned across national health authorities",
                            "level5": "Yes, fully implemented at the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Disability statistics",
                            "level1": "No",
                            "level2": "Defined for facilities/units/teams, but not formally implemented",
                            "level3": "Fully implemented in some facilities/units/teams",
                            "level4": "Fully implemented and aligned across national health authorities",
                            "level5": "Yes, fully implemented at the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Vaccine preventable diseases and Immunization coverage",
                            "level1": "No",
                            "level2": "Defined for facilities/units/teams, but not formally implemented",
                            "level3": "Fully implemented in some facilities/units/teams",
                            "level4": "Fully implemented and aligned across national health authorities",
                            "level5": "Yes, fully implemented at the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Overweight and obesity (Risk Factors)",
                            "level1": "No",
                            "level2": "Defined for facilities/units/teams, but not formally implemented",
                            "level3": "Fully implemented in some facilities/units/teams",
                            "level4": "Fully implemented and aligned across national health authorities",
                            "level5": "Yes, fully implemented at the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Physicians, Nurses, Dentists (Health Systems)",
                            "level1": "No",
                            "level2": "Defined for facilities/units/teams, but not formally implemented",
                            "level3": "Fully implemented in some facilities/units/teams",
                            "level4": "Fully implemented and aligned across national health authorities",
                            "level5": "Yes, fully implemented at the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "The quality of data is monitored",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Cause of Death Data",
                            "level1": "No",
                            "level2": "On an ad hoc basis",
                            "level3": "Routinely for some data sets, but there is a lack of investments for improving data quality. Quality checks are automatized to help data verification.",
                            "level4": "Routinely for all data sets, and there are formal plans, technical discussions and investments for improving data quality issues.",
                            "level5": "Data quality monitored and improved continuously.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Maternal Mortality",
                            "level1": "No",
                            "level2": "On an ad hoc basis",
                            "level3": "Routinely for some data sets, but there is a lack of investments for improving data quality. Quality checks are automatized to help data verification.",
                            "level4": "Routinely for all data sets, and there are formal plans, technical discussions and investments for improving data quality issues.",
                            "level5": "Data quality monitored and improved continuously.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "(Cancer incidence, fasting blood glucose-diabetes) Non Communicable Diseases",
                            "level1": "No",
                            "level2": "On an ad hoc basis",
                            "level3": "Routinely for some data sets, but there is a lack of investments for improving data quality. Quality checks are automatized to help data verification.",
                            "level4": "Routinely for all data sets, and there are formal plans, technical discussions and investments for improving data quality issues.",
                            "level5": "Data quality monitored and improved continuously.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Malaria, Dengue (communicable diseases)",
                            "level1": "No",
                            "level2": "On an ad hoc basis",
                            "level3": "Routinely for some data sets, but there is a lack of investments for improving data quality. Quality checks are automatized to help data verification.",
                            "level4": "Routinely for all data sets, and there are formal plans, technical discussions and investments for improving data quality issues.",
                            "level5": "Data quality monitored and improved continuously.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "HIV - TB (communicable diseases)",
                            "level1": "No",
                            "level2": "On an ad hoc basis",
                            "level3": "Routinely for some data sets, but there is a lack of investments for improving data quality. Quality checks are automatized to help data verification.",
                            "level4": "Routinely for all data sets, and there are formal plans, technical discussions and investments for improving data quality issues.",
                            "level5": "Data quality monitored and improved continuously.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Disability statistics",
                            "level1": "No",
                            "level2": "On an ad hoc basis",
                            "level3": "Routinely for some data sets, but there is a lack of investments for improving data quality. Quality checks are automatized to help data verification.",
                            "level4": "Routinely for all data sets, and there are formal plans, technical discussions and investments for improving data quality issues.",
                            "level5": "Data quality monitored and improved continuously.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Vaccine preventable diseases and Immunization coverage",
                            "level1": "No",
                            "level2": "On an ad hoc basis",
                            "level3": "Routinely for some data sets, but there is a lack of investments for improving data quality. Quality checks are automatized to help data verification.",
                            "level4": "Routinely for all data sets, and there are formal plans, technical discussions and investments for improving data quality issues.",
                            "level5": "Data quality monitored and improved continuously.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Overweight and obesity (Risk Factors)",
                            "level1": "No",
                            "level2": "On an ad hoc basis",
                            "level3": "Routinely for some data sets, but there is a lack of investments for improving data quality. Quality checks are automatized to help data verification.",
                            "level4": "Routinely for all data sets, and there are formal plans, technical discussions and investments for improving data quality issues.",
                            "level5": "Data quality monitored and improved continuously.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Physicians, Nurses, Dentists (Health Systems)",
                            "level1": "No",
                            "level2": "On an ad hoc basis",
                            "level3": "Routinely for some data sets, but there is a lack of investments for improving data quality. Quality checks are automatized to help data verification.",
                            "level4": "Routinely for all data sets, and there are formal plans, technical discussions and investments for improving data quality issues.",
                            "level5": "Data quality monitored and improved continuously.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "IT Infrastructure::Availability and maintenance of Tools, Networks, Hardware and Software to support IS4H. Interoperability among platforms and integration of data repositories.",
                            "level1": "Basic tools and technology (hardware, software, internet connectivity) are not widely available.",
                            "level2": "Basic Tools are generally available but many be older or not performing well.",
                            "level3": "There is evidence of interoperability between some health platforms.",
                            "level4": "Widely available and interoperable across the public health system.",
                            "level5": "There is evidence of significant interoperability across health platforms. Integrated national repositories from multiple data sources.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There is IT governance body in place to supervise ICT standards; ICT performance; policies and to coordinate investments. ",
                            "level1": "There are no formal mechanism for making decisions about IT.",
                            "level2": "Decision about IT are made within the facility/unit/team.",
                            "level3": "The national health authority has established a formal body for making decisions about IT.",
                            "level4": "There is a national body that makes decisions about some aspects of publics sector IT, and coordinates investments.",
                            "level5": "There is a national body that coordinates investments in both public and private sector investments in IT.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Infrastructure availability and performance:",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "End-user devices (mobile, desktop)",
                            "level1": "Not available",
                            "level2": "Generally available but not performing well",
                            "level3": "Widely available and performance meets basic needs",
                            "level4": "Widely available and systems are continuously upgraded",
                            "level5": "Available and high-end/cutting-edge technology and performance",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Local area network",
                            "level1": "Not available",
                            "level2": "Generally available but not performing well",
                            "level3": "Widely available and performance meets basic needs",
                            "level4": "Widely available and systems are continuously upgraded",
                            "level5": "Available and high-end/cutting-edge technology and performance",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Wide area networks",
                            "level1": "Not available",
                            "level2": "Generally available but not performing well",
                            "level3": "Widely available and performance meets basic needs",
                            "level4": "Widely available and systems are continuously upgraded",
                            "level5": "Available and high-end/cutting-edge technology and performance",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Internet connectivity",
                            "level1": "Not available",
                            "level2": "Generally available but not performing well",
                            "level3": "Widely available and performance meets basic needs",
                            "level4": "Widely available and systems are continuously upgraded",
                            "level5": "Available and high-end/cutting-edge technology and performance",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Data hosting",
                            "level1": "Not available",
                            "level2": "Generally available but not performing well",
                            "level3": "Widely available and performance meets basic needs",
                            "level4": "Widely available and systems are continuously upgraded",
                            "level5": "Available and high-end/cutting-edge technology and performance",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Availability of health information solution/platforms",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Hospital Management Information System",
                            "level1": "Not available",
                            "level2": "Available in some facilities",
                            "level3": "Available in all facilities with some interoperability within facilities",
                            "level4": "Interoperability  across public health system",
                            "level5": "Interoperability within the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Electronic Medical Record",
                            "level1": "Not available",
                            "level2": "Available in some facilities",
                            "level3": "Available in all facilities with some interoperability within facilities",
                            "level4": "Interoperability  across public health system",
                            "level5": "Interoperability within the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Electronic Health Record",
                            "level1": "Not available",
                            "level2": "Available in some facilities",
                            "level3": "Available in all facilities with some interoperability within facilities",
                            "level4": "Interoperability  across public health system",
                            "level5": "Interoperability within the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Laboratory Information System",
                            "level1": "Not available",
                            "level2": "Available in some facilities",
                            "level3": "Available in all facilities with some interoperability within facilities",
                            "level4": "Interoperability  across public health system",
                            "level5": "Interoperability within the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Pharmacy Information System",
                            "level1": "Not available",
                            "level2": "Available in some facilities",
                            "level3": "Available in all facilities with some interoperability within facilities",
                            "level4": "Interoperability  across public health system",
                            "level5": "Interoperability within the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Radiology Information System",
                            "level1": "Not available",
                            "level2": "Available in some facilities",
                            "level3": "Available in all facilities with some interoperability within facilities",
                            "level4": "Interoperability  across public health system",
                            "level5": "Interoperability within the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Logistics management information system",
                            "level1": "Not available",
                            "level2": "Available in some facilities",
                            "level3": "Available in all facilities with some interoperability within facilities",
                            "level4": "Interoperability  across public health system",
                            "level5": "Interoperability within the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Picture and Archiving System (PACS)",
                            "level1": "Not available",
                            "level2": "Available in some facilities",
                            "level3": "Available in all facilities with some interoperability within facilities",
                            "level4": "Interoperability  across public health system",
                            "level5": "Interoperability within the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Surveillance information system",
                            "level1": "Not available",
                            "level2": "Available in some facilities",
                            "level3": "Available in all facilities with some interoperability within facilities",
                            "level4": "Interoperability  across public health system",
                            "level5": "Interoperability within the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Mortality information system/national vital statistics system",
                            "level1": "Not available",
                            "level2": "Available in some facilities",
                            "level3": "Available in all facilities with some interoperability within facilities",
                            "level4": "Interoperability  across public health system",
                            "level5": "Interoperability within the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Immunization Information System ",
                            "level1": "Not available",
                            "level2": "Available in some facilities",
                            "level3": "Available in all facilities with some interoperability within facilities",
                            "level4": "Interoperability  across public health system",
                            "level5": "Interoperability within the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Data repositories (data warehouse )",
                            "level1": "Not available",
                            "level2": "Available in some facilities",
                            "level3": "Available in all facilities with some interoperability within facilities",
                            "level4": "Interoperability  across public health system",
                            "level5": "Interoperability within the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There are defined policies and SOPs for IT management.",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Acceptable use policies",
                            "level1": "No",
                            "level2": "Defined for facilities/units/teams, but not formally implemented",
                            "level3": "Fully implemented in some facilities/units/teams",
                            "level4": "Fully implemented and aligned across national health authorities",
                            "level5": "Yes, fully implemented at the national public sector level.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "IT standards policies",
                            "level1": "No",
                            "level2": "Defined for facilities/units/teams, but not formally implemented",
                            "level3": "Fully implemented in some facilities/units/teams",
                            "level4": "Fully implemented and aligned across national health authorities",
                            "level5": "Yes, fully implemented at the national public sector level.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Business continuity and disaster recover SOPS",
                            "level1": "No",
                            "level2": "Defined for facilities/units/teams, but not formally implemented",
                            "level3": "Fully implemented in some facilities/units/teams",
                            "level4": "Fully implemented and aligned across national health authorities",
                            "level5": "Yes, fully implemented at the national public sector level.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "IT security management policies and SOPs",
                            "level1": "No",
                            "level2": "Defined for facilities/units/teams, but not formally implemented",
                            "level3": "Fully implemented in some facilities/units/teams",
                            "level4": "Fully implemented and aligned across national health authorities",
                            "level5": "Yes, fully implemented at the national public sector level.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Evergreening policies (hardware/software renewal)",
                            "level1": "No",
                            "level2": "Defined for facilities/units/teams, but not formally implemented",
                            "level3": "Fully implemented in some facilities/units/teams",
                            "level4": "Fully implemented and aligned across national health authorities",
                            "level5": "Yes, fully implemented at the national public sector level.",
                            "runtimeType": "question"
                        }
                    ]
                }
            ]
        },
        {
            "title": "",
            "groups": [
                {
                    "title": "Leadership and Coordination",
                    "subTitle": "Coordination and distribution of the governance structure for IS4H accountability and decision-making at the managerial and technical level among all actors.",
                    "level1": "Accountability and decision-making for IS4H components is distributed across different units within national health authorities, and investments and activities are not coordinated.",
                    "level2": "IS4H investment decisions are coordinated at the management level within individual national health authorities (e.g., MOH, reginal health authorities, health facilities, etc.) but not formally coordinated among health authorities or other national actors.",
                    "level3": "There is a formal governance structure in place for strategic planning and oversight of IS4H among the national health authorities (e.g. MOH, regional health authorities, health facilities, etc.).",
                    "level4": "IS4H governance structures are established at the national level across at least some key national stakeholders (e.g. health authorities, national IT authorities, vital Statistics,  national statistics authorities)",
                    "level5": "The governance and management of IS4H is fully transparent and integrated across all national stakeholder organizations.",
                    "items": [
                        {
                            "text": "Roles and functions of key national health system actors are formally documented and mapped.",
                            "level1": "No mapping or documentation exist. Knowledge of roles and functions of health system actors resides in individuals",
                            "level2": "Individual institutions have mapped the roles and functions of some key stakeholders but not shared at the national level.",
                            "level3": "There is a formal roster of national health system actors (public and private) documented and available.",
                            "level4": "There is a formal roster of national health system actors (public and private with a mapping of roles and relationships.",
                            "level5": "Health sector functions, roles and responsibilities are mapped, integrated and aligned across national health system actors.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Decisions mechanisms for IS4H strategic priorities, investments and technical approaches.",
                            "level1": "Decision for IS4H are only  addressed at the unit/facility level",
                            "level2": "There is no formal governance structure within the National Health Authority, but IS4H issues are routinely  discussed within the  National Health Authority  executive leadership body.",
                            "level3": "There is a formal IS4H governance structure within the National Health Authority.",
                            "level4": "There is a national governance structure that at a minimum includes National Health Authority, vital statistics authority, national statistics authority, and the national IT/e-gov authority.",
                            "level5": "The national governance structure is integrated with the IS4H governance structure s in  national stakeholder organizations (e.g. organizational IS4H governance structure reference the national IS4H body in Terms of Reference  or reporting structures).",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Strategic and Operational Plans::Addressing IS4H under policies, strategies and SOPs at the national, regional and local level.  Mechanisms for developing or adopting an IS4H governance strategy or policy that promotes a better decision- and informed policy-making mechanisms.",
                            "level1": "There is no current National Health System Strategic Plan, and IS4H components are not reflected in operational plans.",
                            "level2": "There is a National Health System Strategic Plan, but it does not address IS4H.  Some individual units/departments/facilities include some components of IS4H in their operational plans.",
                            "level3": "There is a current National Health System Strategic Plan that include priorities for strengthening health information.  IS4H is included within operational plans of national health authorities.",
                            "level4": "There is a formal strategic plan in place among national health authorities for strengthening IS4H that reflects the IS4H Strategic Framework. Operational plans of the units within national health authorities reflect IS4H activities and outcomes based on the IS4H Strategic Plan.  ",
                            "level5": "There is a National IS4H Strategic Plan, and operational plans are aligned and integrated across multisectoral stakeholders.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There is a National IS4H Strategic Plan.",
                            "level1": "There is no current National Health System Strategic Plan.",
                            "level2": "There is a current National  Health System Strategic Plan, but it does not address components of IS4H.",
                            "level3": "There is a current National Health System Strategic Plan that includes a priority for strengthening health information that reflects two or more strategic domains within the IS4H framework.",
                            "level4": "There is a formal strategic plan in place among national health authorities for strengthening IS4H that reflects all of the domains in the IS4H Strategic Framework",
                            "level5": "There is a specific National IS4H Strategic Plan that include strategic goals and initiatives from multi-sectoral partners.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There are IS4H operational plans.",
                            "level1": "IS4H components are not reflected in operational plans of the national health authority.",
                            "level2": "Some units/departments/facilities include some IS4H components in their individual operating plans.",
                            "level3": "IS4H is specifically included within the operational plans of national health authorities.",
                            "level4": "IS4H is included within the operational plans of national health authorities, and is aligned with National IS4H Strategic Plan.",
                            "level5": "IS4H is included within the operational plans of multisectoral stakeholders, and aligned or integrated across stakeholders within the framework of the National IS4H Strategic Plan.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Organizational Structures and Functions::Organizational Structure & Information flows of health-related institutions. Roles and responsibilities IS4H health system actors.",
                            "level1": "Some IS4H functions are formally defined and performed, but there are significant gaps",
                            "level2": "There are gaps in IS4H services or functions, and/or services and functions may be duplicated across units/programs. ",
                            "level3": "Accountability and responsibility for IS4H functions within national health authorities have been defined, and there are plans in place for organizational restructuring or re-alignment to rationalize functions and decision-making.",
                            "level4": "An organizational structure that defines clear accountabilities and responsibilities for IS4H has been fully implemented within/among national health authorities, and is reflected in unit/program mandates and job descriptions.   ",
                            "level5": "IS4H functions are defined, performed and aligned across national stakeholders.  Functions are integrated  across national stakeholders, optimizing performance, value and investments at the national level.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There is a documented and formally adopted organizational structure (organigram) for the national health authority (e.g. Ministry of Health and/or other national and sub-national health authorities).",
                            "level1": "No formal organizational structure for the national health authorities are defined.",
                            "level2": "Yes, but the organizational structure has not yet been formally approved or published.",
                            "level3": "Yes, but IS4H roles and responsibilities are not fully reflected.",
                            "level4": "Yes, with IS4H roles and responsibilities fully reflected.",
                            "level5": "Yes, with IS4H fully reflected and aligned with organizational structures across national multisectoral partners.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "The overall leadership and accountability for IS4H is defined within the organization is defined.",
                            "level1": "IS4H responsibility is not currently defined in the organization, and there is no clear leadership for IS4H.",
                            "level2": "Responsibility for IS4H is defined within national health authorities for individual components, but there is no clear overall leadership role defined.",
                            "level3": "Leadership for IS4H is defined, and there are formal plans for organizational re-structuring to clearly define roles and responsibilities within the national health authorities.",
                            "level4": "Responsibility for IS4H is defined and integrated within national health authorities, and leadership is well defined.",
                            "level5": "Leadership and accountabilities for IS4H are well defined across multi-sectoral national partners.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Change management program is integrated into the institutional culture-capacity.",
                            "level1": "There is no awareness of the importance of change management at the leadership level.",
                            "level2": "There is awareness of  principles, but no organizational capacity to implement change management methodologies",
                            "level3": "Some capacity for change management but lack organizational resources",
                            "level4": "There are formal and efficient change management program unit or team.",
                            "level5": "Change management is an integral part of initiatives and projects",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There are formally defined organizational functions for:",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Information Technology Management",
                            "level1": "Some IS4H functions formally present and performed with significant gaps.",
                            "level2": "Most functions are performed but not formally defined, and/or their are  overlapping accountabilities or duplication of efforts.",
                            "level3": "Functions are defined, and there are plans to address gaps and to align accountabilities.",
                            "level4": "Functions are fully defined and  accountabilities are aligned within the national health authority",
                            "level5": "Functions are fully defined and accountabilities are aligned across national multisectoral partners",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Information Management and Analysis",
                            "level1": "Some IS4H functions formally present and performed with significant gaps.",
                            "level2": "Most functions are performed but not formally defined, and/or their are  overlapping accountabilities or duplication of efforts.",
                            "level3": "Functions are defined, and there are plans to address gaps and to align accountabilities.",
                            "level4": "Functions are fully defined and  accountabilities are aligned within the national health authority",
                            "level5": "Functions are fully defined and accountabilities are aligned across national multisectoral partners",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Health Informatics",
                            "level1": "Some IS4H functions formally present and performed with significant gaps.",
                            "level2": "Most functions are performed but not formally defined, and/or their are  overlapping accountabilities or duplication of efforts.",
                            "level3": "Functions are defined, and there are plans to address gaps and to align accountabilities.",
                            "level4": "Functions are fully defined and  accountabilities are aligned within the national health authority",
                            "level5": "Functions are fully defined and accountabilities are aligned across national multisectoral partners",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Knowledge and Performance Management",
                            "level1": "Some IS4H functions formally present and performed with significant gaps.",
                            "level2": "Most functions are performed but not formally defined, and/or their are  overlapping accountabilities or duplication of efforts.",
                            "level3": "Functions are defined, and there are plans to address gaps and to align accountabilities.",
                            "level4": "Functions are fully defined and  accountabilities are aligned within the national health authority",
                            "level5": "Functions are fully defined and accountabilities are aligned across national multisectoral partners",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There are policies and standard operating procedures defined to guide activities and processes within the IS4H core functions:",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Information Technology Management",
                            "level1": "There are few, if any, policies/SOPs defined to guide the activities and processes across IS4H domains.",
                            "level2": "There are some policies/SOPs defined to guide IS4H activities and processes, but many are out of date, or not formally adopted within national health authorities.",
                            "level3": "Specific gaps in policies/SOPs have been identified, and there are plans in progress to update and adopt policies/SOPs within national health authorities.",
                            "level4": "Policies/SOPs are well defined and formally adopted to guide IS4H activities and processes within the national health authorities.",
                            "level5": "Policies/SOPs are to guide IS4H activities and processes, and are integrated and aligned across national multi-sectoral stakeholders.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Information Management and Analysis",
                            "level1": "There are few, if any, policies/SOPs defined to guide the activities and processes across IS4H domains.",
                            "level2": "There are some policies/SOPs defined to guide IS4H activities and processes, but many are out of date, or not formally adopted within national health authorities.",
                            "level3": "Specific gaps in policies/SOPs have been identified, and there are plans in progress to update and adopt policies/SOPs within national health authorities.",
                            "level4": "Policies/SOPs are well defined and formally adopted to guide IS4H activities and processes within the national health authorities.",
                            "level5": "Policies/SOPs are to guide IS4H activities and processes, and are integrated and aligned across national multi-sectoral stakeholders.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Health Informatics",
                            "level1": "There are few, if any, policies/SOPs defined to guide the activities and processes across IS4H domains.",
                            "level2": "There are some policies/SOPs defined to guide IS4H activities and processes, but many are out of date, or not formally adopted within national health authorities.",
                            "level3": "Specific gaps in policies/SOPs have been identified, and there are plans in progress to update and adopt policies/SOPs within national health authorities.",
                            "level4": "Policies/SOPs are well defined and formally adopted to guide IS4H activities and processes within the national health authorities.",
                            "level5": "Policies/SOPs are to guide IS4H activities and processes, and are integrated and aligned across national multi-sectoral stakeholders.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Knowledge and Performance Management",
                            "level1": "There are few, if any, policies/SOPs defined to guide the activities and processes across IS4H domains.",
                            "level2": "There are some policies/SOPs defined to guide IS4H activities and processes, but many are out of date, or not formally adopted within national health authorities.",
                            "level3": "Specific gaps in policies/SOPs have been identified, and there are plans in progress to update and adopt policies/SOPs within national health authorities.",
                            "level4": "Policies/SOPs are well defined and formally adopted to guide IS4H activities and processes within the national health authorities.",
                            "level5": "Policies/SOPs are to guide IS4H activities and processes, and are integrated and aligned across national multi-sectoral stakeholders.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Financial Resources::Budget for IS4H implementation, sustainability, investment. Resources mobilization plans and ERP systems.",
                            "level1": "IS4H activities/resources are not formally identified in program/unit budgets. While it is sometimes possible to secure one-time financial resources for IS4H investments, required investments are difficult to sustain.",
                            "level2": "IS4H activities are identified in individual unit/program annual budgets of national health authorities, but are not integrated or aligned across units/programs.   The financial resources requirements to effectively sustain IS4H have been identified, but there is no plan to address gaps.",
                            "level3": "There is a plan in place for resource mobilization for specific IS4H capital investments, and financial resources required for the sustainable implementation and operations of IS4H have been secured with annual budgets.",
                            "level4": "An IS4H investment framework is established at the national level.",
                            "level5": "IS4H is fully sustainable, supported by an investment model that ensures the required human resources, processes, legal-ethical framework, knowledge and technologies are available to deliver ISH effectively, and to continually invest in new capabilities as they emerge.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Financial requirements and resources for IS4H are available.",
                            "level1": "Financial requirements for IS4H are not known, although it is sometime possible to secure one-time, limited financial resources.",
                            "level2": "Financial resource requirements for some components of IS4H are known, but there is no plan in place to address financial resource gaps.",
                            "level3": "Financial requirements for IS4H are known.  Although the required financial resources are not fully available, there is a resource mobilization strategy in place.",
                            "level4": "There is an IS4H investment framework at the national level that identifies financial resource requirements, and investment sources.",
                            "level5": "IS4H is sustainable, supported by an investment model that address both short-term operational finance resource requirements, and longer-term innovation and capacity development.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There are formal budgets for planning, implementing and sustaining IS4H.",
                            "level1": "Budgets do not specifically include line-items for IS4H components.",
                            "level2": "Budgets do no include specific line-items for IS4H components, but budgets do include IS4H components under other line-items (e.g. program budgets).",
                            "level3": "Individual units/departments/facilities have line-items for some IS4H components in their budgets, but it is not possible to roll-up these budgets as the organizational or national health authority level.",
                            "level4": "There are specific budget line-items for IS4H components that are consistent across units/departments/facilities, and that can be rolled up across national health authorities.",
                            "level5": "There are specific budget line-items for IS4H components that are consistent across multi-sectoral stakeholders that can be rolled up at the national level.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Human Resources::Human capital for planning, implementing, and managing IS4H. Competency building activities to strengthen to IS4H skills. Job functions identified to effectively support IS4H.",
                            "level1": "There is little awareness of the human resource requirements to support IS4H.",
                            "level2": "There are identified human resource constraints for planning, implementing, and managing IS4H, but there is no formal plan for addressing human resource needs.",
                            "level3": "Skills and job functions required to effectively support IS4H have been identified, although not all resources have yet been secured. There are is some evidence of competency building activities (training, workshops, conferences) for IS4H domains but these are typically ad hoc.  ",
                            "level4": "Sufficient human resources with the required skills to effectively implement and sustain IS4H have been secured. Relevant IS4H skills and competency development are integrated into training plans for leadership, management and staff.",
                            "level5": "There is a national strategy for building IS4H human resource competencies that includes national and international educational institutions to ensure the long term availability of skilled IS4H resources.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There are identified human resource requirements for:",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Information Technology Management",
                            "level1": "No IS4H human resource requirements have been identified.",
                            "level2": "Human resource requirements have been identified, but there are no formal plans to address gaps",
                            "level3": "There are short-term plans in place to address human resource gaps.",
                            "level4": "There is a long-term IS4H human resources strategy in place that reflects the overall IS4H strategic priorities.",
                            "level5": "There is a national IS4H human resource strategy in place aligned with multisectoral partners.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Information Management and Analysis",
                            "level1": "No IS4H human resource requirements have been identified.",
                            "level2": "Human resource requirements have been identified, but there are no formal plans to address gaps",
                            "level3": "There are short-term plans in place to address human resource gaps.",
                            "level4": "There is a long-term IS4H human resources strategy in place that reflects the overall IS4H strategic priorities.",
                            "level5": "There is a national IS4H human resource strategy in place aligned with multisectoral partners.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Health Informatics",
                            "level1": "No IS4H human resource requirements have been identified.",
                            "level2": "Human resource requirements have been identified, but there are no formal plans to address gaps",
                            "level3": "There are short-term plans in place to address human resource gaps.",
                            "level4": "There is a long-term IS4H human resources strategy in place that reflects the overall IS4H strategic priorities.",
                            "level5": "There is a national IS4H human resource strategy in place aligned with multisectoral partners.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Knowledge and Performance Management",
                            "level1": "No IS4H human resource requirements have been identified.",
                            "level2": "Human resource requirements have been identified, but there are no formal plans to address gaps",
                            "level3": "There are short-term plans in place to address human resource gaps.",
                            "level4": "There is a long-term IS4H human resources strategy in place that reflects the overall IS4H strategic priorities.",
                            "level5": "There is a national IS4H human resource strategy in place aligned with multisectoral partners.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Human resources with the required knowledge and skills to effectively implement and sustain IS4H are available:",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Information Technology Management",
                            "level1": "There are few IS4H human resources available.",
                            "level2": "There are some IS4H human resources available, but not sufficient to effectively plan and implement IS4H.",
                            "level3": "There are IS4H human resources available, but recruitment and retention of skilled resources is an ongoing challenge. ",
                            "level4": "There is enough human resource capacity to effectively sustain IS4H.",
                            "level5": "There is enough human resource capacity to drive continuous innovation across all the core IS4H domains.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Information Management and Analysis",
                            "level1": "There are few IS4H human resources available.",
                            "level2": "There are some IS4H human resources available, but not sufficient to effectively plan and implement IS4H.",
                            "level3": "There are IS4H human resources available, but recruitment and retention of skilled resources is an ongoing challenge. ",
                            "level4": "There is enough human resource capacity to effectively sustain IS4H.",
                            "level5": "There is enough human resource capacity to drive continuous innovation across all the core IS4H domains.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Health Informatics",
                            "level1": "There are few IS4H human resources available.",
                            "level2": "There are some IS4H human resources available, but not sufficient to effectively plan and implement IS4H.",
                            "level3": "There are IS4H human resources available, but recruitment and retention of skilled resources is an ongoing challenge. ",
                            "level4": "There is enough human resource capacity to effectively sustain IS4H.",
                            "level5": "There is enough human resource capacity to drive continuous innovation across all the core IS4H domains.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Knowledge and Performance Management",
                            "level1": "There are few IS4H human resources available.",
                            "level2": "There are some IS4H human resources available, but not sufficient to effectively plan and implement IS4H.",
                            "level3": "There are IS4H human resources available, but recruitment and retention of skilled resources is an ongoing challenge. ",
                            "level4": "There is enough human resource capacity to effectively sustain IS4H.",
                            "level5": "There is enough human resource capacity to drive continuous innovation across all the core IS4H domains.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Leadership and staff have knowledge of key IS4H concepts to effectively plan, implement and support IS4H across the entire organizations.",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Information Technology Management",
                            "level1": "There is a low level of awareness among leadership and staff on key IS4H concepts.",
                            "level2": "There is a developing awareness among leadership and staff of key IS4H concepts.",
                            "level3": "There is adequate knowledge among leadership and staff on key IS4H concepts/skills, and there are ad hoc competency building activities to address knowledge/skill gaps.",
                            "level4": "Leadership and staff have strong knowledge and understanding of key IS4H concepts, and there is a formal IS4H competency building framework in place.",
                            "level5": "Leadership and staff have expert level knowledge of key IS4H concepts and skills.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Information Management and Analysis",
                            "level1": "There is a low level of awareness among leadership and staff on key IS4H concepts.",
                            "level2": "There is a developing awareness among leadership and staff of key IS4H concepts.",
                            "level3": "There is adequate knowledge among leadership and staff on key IS4H concepts/skills, and there are ad hoc competency building activities to address knowledge/skill gaps.",
                            "level4": "Leadership and staff have strong knowledge and understanding of key IS4H concepts, and there is a formal IS4H competency building framework in place.",
                            "level5": "Leadership and staff have expert level knowledge of key IS4H concepts and skills.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Health Informatics",
                            "level1": "There is a low level of awareness among leadership and staff on key IS4H concepts.",
                            "level2": "There is a developing awareness among leadership and staff of key IS4H concepts.",
                            "level3": "There is adequate knowledge among leadership and staff on key IS4H concepts/skills, and there are ad hoc competency building activities to address knowledge/skill gaps.",
                            "level4": "Leadership and staff have strong knowledge and understanding of key IS4H concepts, and there is a formal IS4H competency building framework in place.",
                            "level5": "Leadership and staff have expert level knowledge of key IS4H concepts and skills.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Knowledge and Performance Management",
                            "level1": "There is a low level of awareness among leadership and staff on key IS4H concepts.",
                            "level2": "There is a developing awareness among leadership and staff of key IS4H concepts.",
                            "level3": "There is adequate knowledge among leadership and staff on key IS4H concepts/skills, and there are ad hoc competency building activities to address knowledge/skill gaps.",
                            "level4": "Leadership and staff have strong knowledge and understanding of key IS4H concepts, and there is a formal IS4H competency building framework in place.",
                            "level5": "Leadership and staff have expert level knowledge of key IS4H concepts and skills.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There is capacity within the country to educate, train and strengthen the IS4H workforce:",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Information Technology Management",
                            "level1": "There is no national capacity to educate and train human resources.",
                            "level2": "There is some technical training capacity in the country.",
                            "level3": "There is academic undergraduate education capacity in country.",
                            "level4": "There is postgraduate education capacity in country.",
                            "level5": "There are advance centers for excellent in country that drive research and innovation in the filled.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Information Management and Analysis",
                            "level1": "There is no national capacity to educate and train human resources.",
                            "level2": "There is some technical training capacity in the country.",
                            "level3": "There is academic undergraduate education capacity in country.",
                            "level4": "There is postgraduate education capacity in country.",
                            "level5": "There are advance centers for excellent in country that drive research and innovation in the filled.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Health Informatics",
                            "level1": "There is no national capacity to educate and train human resources.",
                            "level2": "There is some technical training capacity in the country.",
                            "level3": "There is academic undergraduate education capacity in country.",
                            "level4": "There is postgraduate education capacity in country.",
                            "level5": "There are advance centers for excellent in country that drive research and innovation in the filled.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Knowledge and Performance Management",
                            "level1": "There is no national capacity to educate and train human resources.",
                            "level2": "There is some technical training capacity in the country.",
                            "level3": "There is academic undergraduate education capacity in country.",
                            "level4": "There is postgraduate education capacity in country.",
                            "level5": "There are advance centers for excellent in country that drive research and innovation in the filled.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There are established relationships with other public sector stakeholders for information sharing and coordination.",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "National statistics sector",
                            "level1": "No relationships with stakeholders within the broader public sector",
                            "level2": "Information sharing with other health system stakeholders is ad hoc, for some specific information needs.",
                            "level3": "Information sharing with public sector stakeholders  happens routinely, but not based on a formal agreement.",
                            "level4": "There are specific formal intersectoral agreements for information sharing.",
                            "level5": "National IS4H governance structure provides formal arrangements for the sharing of information across multisectoral partners.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Economy",
                            "level1": "No relationships with stakeholders within the broader public sector",
                            "level2": "Information sharing with other health system stakeholders is ad hoc, for some specific information needs.",
                            "level3": "Information sharing with public sector stakeholders  happens routinely, but not based on a formal agreement.",
                            "level4": "There are specific formal intersectoral agreements for information sharing.",
                            "level5": "National IS4H governance structure provides formal arrangements for the sharing of information across multisectoral partners.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Education",
                            "level1": "No relationships with stakeholders within the broader public sector",
                            "level2": "Information sharing with other health system stakeholders is ad hoc, for some specific information needs.",
                            "level3": "Information sharing with public sector stakeholders  happens routinely, but not based on a formal agreement.",
                            "level4": "There are specific formal intersectoral agreements for information sharing.",
                            "level5": "National IS4H governance structure provides formal arrangements for the sharing of information across multisectoral partners.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Social services",
                            "level1": "No relationships with stakeholders within the broader public sector",
                            "level2": "Information sharing with other health system stakeholders is ad hoc, for some specific information needs.",
                            "level3": "Information sharing with public sector stakeholders  happens routinely, but not based on a formal agreement.",
                            "level4": "There are specific formal intersectoral agreements for information sharing.",
                            "level5": "National IS4H governance structure provides formal arrangements for the sharing of information across multisectoral partners.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Police/justice",
                            "level1": "No relationships with stakeholders within the broader public sector",
                            "level2": "Information sharing with other health system stakeholders is ad hoc, for some specific information needs.",
                            "level3": "Information sharing with public sector stakeholders  happens routinely, but not based on a formal agreement.",
                            "level4": "There are specific formal intersectoral agreements for information sharing.",
                            "level5": "National IS4H governance structure provides formal arrangements for the sharing of information across multisectoral partners.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There are established relationships with private sector stakeholders for information sharing and coordination.",
                            "level1": "No relationships with stakeholders within the private sector",
                            "level2": "Information sharing with private sector stakeholders is ad hoc, for some specific information needs.",
                            "level3": "Information sharing with private sector stakeholders  happens routinely, but not based on a formal agreement.",
                            "level4": "There are specific formal agreements for information sharing with private sector stakeholders.",
                            "level5": "National IS4H governance structure provides formal arrangements for the sharing of information across private sector partners.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There are established relationships with international organizations and NGOs  for information sharing and coordination.",
                            "level1": "No relationships with international organizations/NGO stakeholders.",
                            "level2": "Information sharing with international/NGO stakeholders is ad hoc, for some specific information needs.",
                            "level3": "Information sharing with international organizations/NGO stakeholders  happens routinely, but not based on a formal agreement.",
                            "level4": "There are specific formal agreements for information sharing with international/NGO stakeholders.",
                            "level5": "National IS4H governance structure provides formal arrangements for the sharing of information across international/NGO partners.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Legislation, Policy and Compliance::Key and core legislation, policy and compliance mechanisms, elements to enable IS4H implementation, operation and maintenance. ",
                            "level1": "There is some awareness that there are gaps in legislation, policy and compliance mechanisms that create barriers to the effective use of IS4H, but specific gaps and needs have not been formally documented.",
                            "level2": "Requirements for IS4H enabling legislation, policy and compliance mechanism have been identified, but solutions have not yet implemented.",
                            "level3": "There are policies and SOPs that address ethical use and protection of health data (e.g., privacy, security, secondary use), but there may be gaps in regulation or legislation. ",
                            "level4": "The legislation, policies, and compliance mechanism required to effectively implement and operate IS4H are implemented. ",
                            "level5": "The legal-ethical framework fully enables the use of information and technology to improve health outcomes and the performance of the health system while protecting individuals and populations, and is responsive to emerging innovations.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There is a legislation/regulation for the mandatory reporting of:",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Vital Statistics",
                            "level1": "No or not sure.",
                            "level2": "Yes, but out of date or not adequate.",
                            "level3": "Yes, but out of date or not adequate. However, there are formal plans in place to address gaps.",
                            "level4": "Yes, up to date, implemented and routinely maintained.",
                            "level5": "Yes, and mechanism are able to accommodate emergent requirements driven by innovations or new strategic priorities.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Maternal Mortality",
                            "level1": "No or not sure.",
                            "level2": "Yes, but out of date or not adequate.",
                            "level3": "Yes, but out of date or not adequate. However, there are formal plans in place to address gaps.",
                            "level4": "Yes, up to date, implemented and routinely maintained.",
                            "level5": "Yes, and mechanism are able to accommodate emergent requirements driven by innovations or new strategic priorities.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Neonatal Mortality",
                            "level1": "No or not sure.",
                            "level2": "Yes, but out of date or not adequate.",
                            "level3": "Yes, but out of date or not adequate. However, there are formal plans in place to address gaps.",
                            "level4": "Yes, up to date, implemented and routinely maintained.",
                            "level5": "Yes, and mechanism are able to accommodate emergent requirements driven by innovations or new strategic priorities.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Non Communicable Diseases",
                            "level1": "No or not sure.",
                            "level2": "Yes, but out of date or not adequate.",
                            "level3": "Yes, but out of date or not adequate. However, there are formal plans in place to address gaps.",
                            "level4": "Yes, up to date, implemented and routinely maintained.",
                            "level5": "Yes, and mechanism are able to accommodate emergent requirements driven by innovations or new strategic priorities.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Communicable Diseases",
                            "level1": "No or not sure.",
                            "level2": "Yes, but out of date or not adequate.",
                            "level3": "Yes, but out of date or not adequate. However, there are formal plans in place to address gaps.",
                            "level4": "Yes, up to date, implemented and routinely maintained.",
                            "level5": "Yes, and mechanism are able to accommodate emergent requirements driven by innovations or new strategic priorities.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Disability",
                            "level1": "No or not sure.",
                            "level2": "Yes, but out of date or not adequate.",
                            "level3": "Yes, but out of date or not adequate. However, there are formal plans in place to address gaps.",
                            "level4": "Yes, up to date, implemented and routinely maintained.",
                            "level5": "Yes, and mechanism are able to accommodate emergent requirements driven by innovations or new strategic priorities.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Immunizations",
                            "level1": "No or not sure.",
                            "level2": "Yes, but out of date or not adequate.",
                            "level3": "Yes, but out of date or not adequate. However, there are formal plans in place to address gaps.",
                            "level4": "Yes, up to date, implemented and routinely maintained.",
                            "level5": "Yes, and mechanism are able to accommodate emergent requirements driven by innovations or new strategic priorities.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Risk Factors",
                            "level1": "No or not sure.",
                            "level2": "Yes, but out of date or not adequate.",
                            "level3": "Yes, but out of date or not adequate. However, there are formal plans in place to address gaps.",
                            "level4": "Yes, up to date, implemented and routinely maintained.",
                            "level5": "Yes, and mechanism are able to accommodate emergent requirements driven by innovations or new strategic priorities.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Health Systems",
                            "level1": "No or not sure.",
                            "level2": "Yes, but out of date or not adequate.",
                            "level3": "Yes, but out of date or not adequate. However, there are formal plans in place to address gaps.",
                            "level4": "Yes, up to date, implemented and routinely maintained.",
                            "level5": "Yes, and mechanism are able to accommodate emergent requirements driven by innovations or new strategic priorities.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There are compliance mechanisms for mandatory reporting for the following types of data:",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Vital Statistics",
                            "level1": "No or not sure.",
                            "level2": "Yes, but not enforced.",
                            "level3": "Yes, but not consistently enforced because of policy or lack of resources.",
                            "level4": "Yes, and enforced consistently and effectively.",
                            "level5": "Yes, and compliance mechanisms are able to accommodate emergent reporting needs.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Maternal Mortality",
                            "level1": "No or not sure.",
                            "level2": "Yes, but not enforced.",
                            "level3": "Yes, but not consistently enforced because of policy or lack of resources.",
                            "level4": "Yes, and enforced consistently and effectively.",
                            "level5": "Yes, and compliance mechanisms are able to accommodate emergent reporting needs.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Neonatal Mortality",
                            "level1": "No or not sure.",
                            "level2": "Yes, but not enforced.",
                            "level3": "Yes, but not consistently enforced because of policy or lack of resources.",
                            "level4": "Yes, and enforced consistently and effectively.",
                            "level5": "Yes, and compliance mechanisms are able to accommodate emergent reporting needs.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Non Communicable Diseases",
                            "level1": "No or not sure.",
                            "level2": "Yes, but not enforced.",
                            "level3": "Yes, but not consistently enforced because of policy or lack of resources.",
                            "level4": "Yes, and enforced consistently and effectively.",
                            "level5": "Yes, and compliance mechanisms are able to accommodate emergent reporting needs.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Communicable Diseases",
                            "level1": "No or not sure.",
                            "level2": "Yes, but not enforced.",
                            "level3": "Yes, but not consistently enforced because of policy or lack of resources.",
                            "level4": "Yes, and enforced consistently and effectively.",
                            "level5": "Yes, and compliance mechanisms are able to accommodate emergent reporting needs.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Disability",
                            "level1": "No or not sure.",
                            "level2": "Yes, but not enforced.",
                            "level3": "Yes, but not consistently enforced because of policy or lack of resources.",
                            "level4": "Yes, and enforced consistently and effectively.",
                            "level5": "Yes, and compliance mechanisms are able to accommodate emergent reporting needs.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Immunizations",
                            "level1": "No or not sure.",
                            "level2": "Yes, but not enforced.",
                            "level3": "Yes, but not consistently enforced because of policy or lack of resources.",
                            "level4": "Yes, and enforced consistently and effectively.",
                            "level5": "Yes, and compliance mechanisms are able to accommodate emergent reporting needs.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Risk factors",
                            "level1": "No or not sure.",
                            "level2": "Yes, but not enforced.",
                            "level3": "Yes, but not consistently enforced because of policy or lack of resources.",
                            "level4": "Yes, and enforced consistently and effectively.",
                            "level5": "Yes, and compliance mechanisms are able to accommodate emergent reporting needs.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Health Systems",
                            "level1": "No or not sure.",
                            "level2": "Yes, but not enforced.",
                            "level3": "Yes, but not consistently enforced because of policy or lack of resources.",
                            "level4": "Yes, and enforced consistently and effectively.",
                            "level5": "Yes, and compliance mechanisms are able to accommodate emergent reporting needs.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There is a policy for the ethical collection and secondary use of data that recognizes the inherent biases in data and analyses.",
                            "level1": "No",
                            "level2": "Some guidelines exist, but there is no formal policy.",
                            "level3": "Some facilities/units/areas have polices as part of their institutional policy framework.",
                            "level4": "There are policies at the national level for the public health sector.",
                            "level5": "There are policies at the national level that apply to all national multi-sectoral stakeholders.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There is legislation/regulation enabling the effective use of electronic medical records.",
                            "level1": "No",
                            "level2": "Some guidelines exist, but there is no formal policy, regulation or legislation.",
                            "level3": "There are formal policies in place governing the effective use of electronic medical records.",
                            "level4": "There is legislation that enables the effective use of electronic medical records.",
                            "level5": "There is legislation that enables the effective use of a national electronic health record.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There is legislation/regulation addressing the protection of personal health information (health information privacy).",
                            "level1": "No",
                            "level2": "There is general legislation that addresses the protection of data, but it does not specifically address electronic health information.",
                            "level3": "There are regulatory/policy mechanisms that addresses the protection of health information, within a general data protection legal framework.",
                            "level4": "There is a legislation that specifically address the protection of personal health information in the context of electronic health information.",
                            "level5": "The legal and regulatory framework is flexible and able to accommodate emergent requirements for the protection of personal health information.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "National and International Agreements::National and International agreements to contextualize national plans and investments.  Commitment to regional and global mandates.",
                            "level1": "There is some awareness of data and reporting obligations under national and international agreements, but little capacity to meet obligations.",
                            "level2": "Data and reporting obligations under national and international agreements are frequently met, but with high resource impact.",
                            "level3": "Data and reporting obligations under national and international agreements are consistently met with an effective use of resources.",
                            "level4": "Agreements enable data and information sharing across national and international stakeholders.",
                            "level5": "Data and information are able to flow freely among national and international partners in support of agreements, guided by frameworks that ensure the ethical use of information that protects individuals and populations.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Capacity to meet data and reporting obligations under national and international agreements.",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "IHR",
                            "level1": "There is little capacity to meeting data and reporting obligations.",
                            "level2": "There is some capacity to meet data and reporting obligations, but with high resource impact.",
                            "level3": "There is sufficient capacity to meet national data and reporting obligations with an effective use of resources.",
                            "level4": "There is sufficient capacity to meet national and international data and reporting obligations with an effective use of resources.",
                            "level5": "Systems, process and agreements allow data to flow freely between national and international partners.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "SDG´s",
                            "level1": "There is little capacity to meeting data and reporting obligations.",
                            "level2": "There is some capacity to meet data and reporting obligations, but with high resource impact.",
                            "level3": "There is sufficient capacity to meet national data and reporting obligations with an effective use of resources.",
                            "level4": "There is sufficient capacity to meet national and international data and reporting obligations with an effective use of resources.",
                            "level5": "Systems, process and agreements allow data to flow freely between national and international partners.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "PAHO Core Indicators",
                            "level1": "There is little capacity to meeting data and reporting obligations.",
                            "level2": "There is some capacity to meet data and reporting obligations, but with high resource impact.",
                            "level3": "There is sufficient capacity to meet national data and reporting obligations with an effective use of resources.",
                            "level4": "There is sufficient capacity to meet national and international data and reporting obligations with an effective use of resources.",
                            "level5": "Systems, process and agreements allow data to flow freely between national and international partners.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "National statistical reporting requirements",
                            "level1": "There is little capacity to meeting data and reporting obligations.",
                            "level2": "There is some capacity to meet data and reporting obligations, but with high resource impact.",
                            "level3": "There is sufficient capacity to meet national data and reporting obligations with an effective use of resources.",
                            "level4": "There is sufficient capacity to meet national and international data and reporting obligations with an effective use of resources.",
                            "level5": "Systems, process and agreements allow data to flow freely between national and international partners.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Agreements enable data and information sharing.",
                            "level1": "There is no formal data sharing among national stakeholders.",
                            "level2": "There is some data sharing among national stakeholders, but data sharing requirements new agreements or approvals each time.",
                            "level3": "Data can be shared routinely among national stakeholders, which contributes to national capacity to meeting national and international data and reporting obligations.",
                            "level4": "Data can be shared routinely among national and international stakeholders, which contributes to national capacity to meeting national and international data and reporting obligations.",
                            "level5": "Data is able to flow freely among national and international partners guided by frameworks that ensure the ethical use of information that protects individuals and populations.",
                            "runtimeType": "question"
                        }
                    ]
                }
            ]
        },
        {
            "title": "",
            "groups": [
                {
                    "title": "Knowledge Processes",
                    "subTitle": "Knowledge management methodologies and mechanisms to improve decision-making, capture, share and measure organizational knowledge.",
                    "level1": "Knowledge sharing in the organization is ad hoc and Organizational knowledge resides with key individuals rather that on repeatable processes documented in unit descriptions, job descriptions, policies and SOPs.",
                    "level2": "There are some basic knowledge management mechanism and processes (e.g. formal meeting notes, trip reports, SOPs, documentation etc.) in place but not always accessible and updated, but these are not required in policy or practice.",
                    "level3": "There are numerous knowledge management processes defined (lessons learned, trip reports, mentoring, shadowing, etc.) guided by formal policies and procedures. There is a formal basic KM strategy at the organizational level",
                    "level4": "Knowledge management  sharing is integrated into business processes, job descriptions and organizational functions. Metrics are used to quantitatively measure organizational knowledge management processes and capacities, and continuously improve performance.",
                    "level5": "Health authorities and their multisectoral partners are fully learning organizations: The organizational culture encourages the free-flow of knowledge throughout the organization, enabled by KM processes, tools and technology.",
                    "items": [
                        {
                            "text": "There is an official institutional taxonomy for the classification of documents",
                            "level1": "Not used",
                            "level2": "Awarded of them but not implemented",
                            "level3": "Defined and implemented in some facilities",
                            "level4": "Formally defined and adopted institution wide",
                            "level5": "Fully implemented nationally",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Use of KM metrics ",
                            "level1": "There are no metrics on the use of KM tools",
                            "level2": "There are some metrics of use on some KM tools used for basic use reports to authorities",
                            "level3": "Metrics are used to quantitatively measure organizational knowledge management processes and capacities",
                            "level4": "Result of KM metrics is used for statistics and diagnosis",
                            "level5": "The result of KM metrics Are used to improve performance",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Knowledge transfer from experienced to new staff is",
                            "level1": "Not practiced",
                            "level2": "Practiced ad hoc as an individual initiative",
                            "level3": "Process and/or SOP under development",
                            "level4": "Part of the Institutional policy, but not consistently practiced ",
                            "level5": "Part of the Institutional policy and fully implemented",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Organizational knowledge is shared",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas do as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization   ",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There is a coaching and mentoring program",
                            "level1": "No",
                            "level2": "Practiced ad hoc as an individual initiative",
                            "level3": "Some facilities/units/teams are developing a program, currently informal initiatives",
                            "level4": "Most facilities/units/teams have a program in place",
                            "level5": "In process of implementation through all the institution",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There are established KM institutional methodologies for",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Preservation of the institutional memory",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confidence",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Open access/open source",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confidence",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Research for health",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confidence",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Repositories",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confidence",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Information access",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confidence",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Editorial or publishing ",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confidence",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Mentoring",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confidence",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Travel reports",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confidence",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Meeting reports",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confidence",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Communities of practice",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confidence",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Lessons learned",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confidence",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Critical Information sharing and managing",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confidence",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Virtual meetings",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confidence",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Social networking",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confidence",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There is a KM policy including",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Preservation of the institutional memory",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Open access/open source",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Research for health",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Repositories",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Information access",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Editorial or publishing ",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Mentoring",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Travel reports",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Meeting reports",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Communities of practice",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Lessons learned",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Critical Information sharing and managing",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Virtual meetings",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Social networking",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There are KM SOPs on",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Preservation of the Institutional Memory",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Open access/open source",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Research for health",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Repositories",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Information access",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Editorial or publishing ",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Mentoring",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Communities of practice",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Lessons learned",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Critical Information sharing and managing",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Virtual meetings",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Social networking",
                            "level1": "No",
                            "level2": "On demand and in person, is an individual voluntary process based on confident",
                            "level3": "Some facilities/units/areas have, as part of their institutional processes  ",
                            "level4": "Formal process under development in the entire organization",
                            "level5": "Established in a formal process  and operationalized among areas of the organization with continuous improvement",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Knowledge Architecture::Knowledge management and sharing policies, processes, infrastructure, tools and skills strengthening as part of a learning organization framework.",
                            "level1": "Knowledge management is felt as a need, but there is a few knowledge and expertise in this matter. Although some basic knowledge management technologies and tools are available (physical library of internal resources, shared drives), they are not consistently or organized.  Accessing organizational knowledge is time-consuming and difficult.",
                            "level2": "There is an awareness among leadership and staff of the key concepts and importance of knowledge management. Some isolated KM&S pilot projects (no necessarily by management initiative)",
                            "level3": "Basic KM infrastructure (e.g., share information repositories, content management standards, etc.) is in place.  Some CG projects have been launched at some levels of the organizational structure. KM skills strengthening is part of a training program",
                            "level4": "A formal knowledge management framework has been established within the organizations, with robust policies, processes and mechanisms for knowledge management and knowledge sharing.",
                            "level5": "The KM&S systems are fully operational. Integration of technology with content architecture.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Organizational Knowledge is accessible through:",
                            "level1": "Not accessible ",
                            "level2": "Separate,  physical repositories",
                            "level3": "A central physical repository/library",
                            "level4": "Separate electronic repositories, shared drives, intranet",
                            "level5": "Digital/open Institutional Memory repository",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Knowledge management and sharing is integrated into business processes, job descriptions and organizational functions",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do but not routinely",
                            "level3": "Some facilities/units/teams do routinely",
                            "level4": "In process of implementation through all the institution",
                            "level5": "Yes",
                            "runtimeType": "question"
                        },
                        {
                            "text": "HR Competencies include Knowledge Management and related topics",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do but not routinely",
                            "level3": "Some facilities/units/teams do routinely",
                            "level4": "In process of implementation through all the institution",
                            "level5": "Yes",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Technical staff KM Skills are ",
                            "level1": "Beginner (a few knowledge)",
                            "level2": "Developing (awareness among leadership and staff of the key concepts)",
                            "level3": "Competent (KM skills strengthening is part of a training program)",
                            "level4": "Advanced (Continuous capacity building framework on KM in place)",
                            "level5": "Expert (Health staff and leadership incorporate functionally their KM Knowledge in their routine activities)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There is an agenda/curriculum for training staff on:",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Use of scientific information for health-related decision making ",
                            "level1": "No",
                            "level2": "Training is encouraged but not formalized capacitation curriculum exists, ",
                            "level3": "In process of implementation through institution into the HR policy and partially enforced.",
                            "level4": "Yes, implementation based roadmap is ongoing but not fully implemented, effective resources allocation varies with years",
                            "level5": "Yes, fully implemented and resourced",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Knowledge production",
                            "level1": "No",
                            "level2": "Training is encouraged but not formalized capacitation curriculum exists, ",
                            "level3": "In process of implementation through institution into the HR policy and partially enforced.",
                            "level4": "Yes, implementation based roadmap is ongoing but not fully implemented, effective resources allocation varies with years",
                            "level5": "Yes, fully implemented and resourced",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Knowledge management & sharing",
                            "level1": "No",
                            "level2": "Training is encouraged but not formalized capacitation curriculum exists, ",
                            "level3": "In process of implementation through institution into the HR policy and partially enforced.",
                            "level4": "Yes, implementation based roadmap is ongoing but not fully implemented, effective resources allocation varies with years",
                            "level5": "Yes, fully implemented and resourced",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Knowledge access",
                            "level1": "No",
                            "level2": "Training is encouraged but not formalized capacitation curriculum exists, ",
                            "level3": "In process of implementation through institution into the HR policy and partially enforced.",
                            "level4": "Yes, implementation based roadmap is ongoing but not fully implemented, effective resources allocation varies with years",
                            "level5": "Yes, fully implemented and resourced",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Use and evaluation of information technologies in order to support health priorities",
                            "level1": "No",
                            "level2": "Training is encouraged but not formalized capacitation curriculum exists, ",
                            "level3": "In process of implementation through institution into the HR policy and partially enforced.",
                            "level4": "Yes, implementation based roadmap is ongoing but not fully implemented, effective resources allocation varies with years",
                            "level5": "Yes, fully implemented and resourced",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Leadership and staff awareness of Knowledge Management is",
                            "level1": "Beginner (a few knowledge)",
                            "level2": "Developing (awareness among leadership and staff of the key concepts)",
                            "level3": "Competent (IS4H skills strengthening is part of a training program)",
                            "level4": "Advanced (Continuous capacity building framework on in place)",
                            "level5": "Expert (Health staff and leadership incorporate functionally their KM Knowledge in their routine activities)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "The institution uses ICT tools and platforms  that facilitate communication",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Social networks",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine, with their own selection criteria.",
                            "level4": "Yes, there are key shared tools and platforms among public health system",
                            "level5": "Yes, standardized and interoperable among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Web 2.0",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine, with their own selection criteria.",
                            "level4": "Yes, there are key shared tools and platforms among public health system",
                            "level5": "Yes, standardized and interoperable among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Direct Messaging",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine, with their own selection criteria.",
                            "level4": "Yes, there are key shared tools and platforms among public health system",
                            "level5": "Yes, standardized and interoperable among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "APPs ",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine, with their own selection criteria.",
                            "level4": "Yes, there are key shared tools and platforms among public health system",
                            "level5": "Yes, standardized and interoperable among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "The institution uses ICT tools and platforms that facilitate knowledge exchange and effective collaboration:",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Web Conferences (e.g.: WebEx, Blackboard, Skype, Adobe Connect. etc.)",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine, with their own selection criteria.",
                            "level4": "Yes, there are key shared tools and platforms among public health system",
                            "level5": "Yes, standardized and interoperable among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Collaborative platforms / Forum",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine, with their own selection criteria.",
                            "level4": "Yes, there are key shared tools and platforms among public health system",
                            "level5": "Yes, standardized and interoperable among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Video Conference (CISCO)",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine, with their own selection criteria.",
                            "level4": "Yes, there are key shared tools and platforms among public health system",
                            "level5": "Yes, standardized and interoperable among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Communities of Practice",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine, with their own selection criteria.",
                            "level4": "Yes, there are key shared tools and platforms among public health system",
                            "level5": "Yes, standardized and interoperable among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There is a methodology/process/policy to facilitate public access to contents resulting  from research activities financed primarily by public funds",
                            "level1": "No",
                            "level2": "Some facilities/units/areas do as part of their institutional processes  ",
                            "level3": "Formal process under development in the entire organization",
                            "level4": "Yes, established in a formal process  and operationalized among areas of the organization for some calefied staff",
                            "level5": "Yes, established in a formal process  and operationalized among areas of the organization for some al staff and sustainable",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Strategic Communications::Strategic tools and methodologies for supported decision-making. Public health communication strategy on national priority issues, as well as promoting (individual, social, and political) changes that lead to achievement and maintenance of health.",
                            "level1": "There are routine public health communications on national priority issues (e.g., healthy lifestyle, vector control, etc.). Data and information typically flow only from source to the central level.",
                            "level2": "A informal public health communication strategy in in place, not operationalized. Public health strategic communications include healthy life style and prevention issues",
                            "level3": "A formal public health communication strategy in place with targeted messages to specific audiences.",
                            "level4": "There is a public health communication strategy with defined messages customized for specific audiences and purposes informed by national evidence. National authorities can measure the impact of strategic communications,  and adjust communications strategies accordingly.",
                            "level5": "Strategic communications are informed by advanced analytics in near real-time.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Public health communication strategy",
                            "level1": "No, some communications are oriented to National Priority issues when occur (vector control, outbreaks, disasters)",
                            "level2": "Not a formal communication strategy in place, but there are routine ad hoc communication messages that include e.g. healthy life style and prevention issues ",
                            "level3": "Yes, There is a health communication strategy with targeted messages to specific audiences",
                            "level4": "There is a health communication strategy with targeted messages to specific audiences and purposes informed by national evidence",
                            "level5": "Yes, Health Communications strategy allows flexibility and opportunity on interventions, oriented by advanced analytics in near real-time.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Data and information flow ",
                            "level1": "Information available stays at the level of collection, used for self reports or specific reports to national or international level",
                            "level2": "Routinely from sources to central level, with no feedback to the local level ",
                            "level3": "Routinely from sources to central level, with some feedback to the local level with key information.",
                            "level4": "There is feedback from central to local level",
                            "level5": "There is an integration of all sources levels for information use. Horizontal flow of information with permanent feedback",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Impact of strategic communications is measured",
                            "level1": "No",
                            "level2": "Yes, for some specific issues, not as routine",
                            "level3": "Yes, routinely for all the communications to inform leadership",
                            "level4": "Yes, and communications strategies are adjusted accordingly",
                            "level5": "Impact of health communications is measured in real time by unstructured data, social networks.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Strategic communications are informed by",
                            "level1": "National Data",
                            "level2": "National and International Data",
                            "level3": "International evidence",
                            "level4": "National and international evidence",
                            "level5": "Advanced analytics, unstructured data ",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Health information for health service delivery management is used ",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do but not routinely",
                            "level3": "Some facilities/units/teams do routinely",
                            "level4": "In process of implementation through all the institution",
                            "level5": "Yes",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Social Participation::Transparency and sound communication in an early stage can build trust in the system and facilitate contributions and cooperation across different sections of society. Communication and engagement with civil society and the public through mechanisms for active encouragement and transparent decision making process.",
                            "level1": "Communication with civil society and the public is typically “one-way” (e.g., through websites and advertising).   ",
                            "level2": "There is limited engagement with civil society and the public through basic mechanisms such as surveys and focus groups.",
                            "level3": "The participation of civil society in the health system is actively encouraged through social media and formal roles on governance bodies and advisory groups.",
                            "level4": "Civil society organizations and the public are constantly engaged ",
                            "level5": "Decisions by health authorities and other health system actors are transparent, driven by evidence and engagement with civil society and the public.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Communication mechanisms with civil society and the public",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "One way (websites, advertising, etc.)",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine, with their own selection criteria.",
                            "level4": "Yes , there are key shared tools and platforms among public health system",
                            "level5": "Yes standardized and interoperable among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Specific commemorative activities (campaigns)",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine, with their own selection criteria.",
                            "level4": "Yes , there are key shared tools and platforms among public health system",
                            "level5": "Yes standardized and interoperable among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Surveys ",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine, with their own selection criteria.",
                            "level4": "Yes , there are key shared tools and platforms among public health system",
                            "level5": "Yes standardized and interoperable among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Focus groups",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine, with their own selection criteria.",
                            "level4": "Yes , there are key shared tools and platforms among public health system",
                            "level5": "Yes standardized and interoperable among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Social networks and website interaction",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine, with their own selection criteria.",
                            "level4": "Yes , there are key shared tools and platforms among public health system",
                            "level5": "Yes standardized and interoperable among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Participation in governance bodies",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine, with their own selection criteria.",
                            "level4": "Yes , there are key shared tools and platforms among public health system",
                            "level5": "Yes standardized and interoperable among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Participation in advisory groups",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine, with their own selection criteria.",
                            "level4": "Yes , there are key shared tools and platforms among public health system",
                            "level5": "Yes standardized and interoperable among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Civil society and/or the public are included in health decisions",
                            "level1": "No",
                            "level2": "Yes, through indirect methods like surveys",
                            "level3": "Yes, through direct methods as surveys or focus groups; community meetings/forums",
                            "level4": "Yes, as part of standing advisory or decision-making bodies;",
                            "level5": "Yes, Integrated into decision-making through a variety of engagement mechanisms, continuously",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Academia & Scientific Community::The academic and scientific communities contribute to research and producing new knowledge in health.",
                            "level1": "No formal relationships have been established between health authorities and the academic/scientific community.",
                            "level2": "Relations with academia are fluid, informal and on demand",
                            "level3": "Formal relationships with academia have been established to expand organizational knowledge and learning.",
                            "level4": "Formal relationships have been established with academia/scientific community focused on supporting projects and programs with specific studies.",
                            "level5": "Formal relationships have been established with academia/scientific community focused on supporting specific projects or studies, support decision-making and programs evaluation.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "The organization formally integrates academic institutions in",
                            "level1": "No integration or collaboration",
                            "level2": "No, there are informal relations, not supported by formal documents, based on relations among staff and academia personnel.",
                            "level3": "Expand organizational knowledge and learning. (training activities) based on formal relationship",
                            "level4": "Public health interventions, through their experts support, ongoing with results. ",
                            "level5": "To support the process of public health policy making through evidence integration and public health programs evaluation",
                            "runtimeType": "question"
                        },
                        {
                            "text": "The organization has an expert advisory group of selected external experts",
                            "level1": "No technical advisory group",
                            "level2": "No, but experts are consulted ad hoc for some specific program/units/staff/leadership, to solve specific problems",
                            "level3": "No, in process of implementation. The group works ad hoc.",
                            "level4": "Yes, if needed, a group is convocated for specific needs on policy and decision-making based on evidence but does not meet regularly",
                            "level5": "Yes, there are all the technical advisory groups needed in place, that meet regularly. ",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Networks::Different types of networks will be implemented, such as: strategic and diplomatic networks of relations, thematic and knowledge networks, and social networks for community engagement.",
                            "level1": "Networks for knowledge sharing are typically ad hoc and informal.",
                            "level2": "Staff participate in knowledge networks (e.g. communities of practice, conferences, listservs) on ad hoc basis",
                            "level3": "Participation in communities of practice is encouraged and staff routinely capture and share knowledge from these forums.",
                            "level4": "Knowledge networks are integrated into organizational structures and practices by a resources and compensations program.",
                            "level5": "As an integrated organizational practice, participating and creating networks is focused in helping the organization to continually identify and adopt emerging knowledge. ",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There are internal networks for knowledge sharing ",
                            "level1": "No, but staff participates and organize ad hoc",
                            "level2": "Staff and leadership participates ad hoc in local initiatives. (communities of practice, conferences, listservs)",
                            "level3": "Participation in knowledge networks is encouraged and led by leadership and is known as an essential way for capturing and sharing knowledge.",
                            "level4": "Organization and development of knowledge network for capturing and sharing knowledge is resourced and implemented",
                            "level5": "Knowledge networks are integrated into organizational structures and practices as a way of identify and adopt emerging knowledge",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Interprogramatic networks for specific projects are ",
                            "level1": "Not created, the decisions are made by the entity, staff with the direct responsibility",
                            "level2": "No, but some teams creates ad hoc networks to implement some projects",
                            "level3": "There are some successful formal initiatives at the local/team level, but not part of routine.",
                            "level4": "Yes, is encouraged by management as part of project implementation.",
                            "level5": "There is a mechanism in place for each project to create interprogramatic or multisectoral networks to generate a better impact and results.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Participation in international networks for knowledge sharing ",
                            "level1": "No",
                            "level2": "Staff and leadership participates ad hoc in international initiatives. (communities of practice, conferences, listservs)",
                            "level3": "Participation in international knowledge network is encouraged by leadership, as an essential way for capturing and sharing knowledge.",
                            "level4": "Participation in international knowledge network is part of the staff responsibility and its included in their job descriptions",
                            "level5": "Is integrated into organizational structures and practices as a way of identify and adopt emerging knowledge",
                            "runtimeType": "question"
                        }
                    ]
                }
            ]
        },
        {
            "title": "",
            "groups": [
                {
                    "title": "Key Concepts",
                    "subTitle": "Leadership and staff awareness and knowledge of IS4H key concepts: big data, open data, predictive analytics, social analytics, forecasting, modelling, and more…",
                    "level1": "leadership and staff are not familiar with IS4H concepts",
                    "level2": "While some IS4H concepts are understood, leadership and staff are not widely aware of all concepts.  ",
                    "level3": "Most leadership and staff have an understanding IS4H concepts.  There are recent assessments that demonstrate strong digital literary among most leadership and staff.",
                    "level4": "Knowledge of IS4H Key Concepts and digital literacy is high among leadership and staff, and there is evidence that these concepts are routinely applied in practice at all levels of the organization.",
                    "level5": "Knowledge of IS4H Key Concepts and digital literacy is high among leadership and staff, and there is evidence that these concepts are routinely applied in practice at all levels and across sectors.",
                    "items": [
                        {
                            "text": "Leadership and staff have awareness of IS4H concepts",
                            "level1": "Beginner ",
                            "level2": "Developing (awareness among leadership and staff of the basic concepts)",
                            "level3": "Competent (IS4H skills strengthening is part of a training program)",
                            "level4": "Advanced (Continuous capacity building framework on IS4H in place)",
                            "level5": "Expert (Health staff and leadership incorporate functionally their IS4H Knowledge in their routine activities)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Leadership and Staff are digitally literate",
                            "level1": "Beginner",
                            "level2": "Developing (awareness among leadership and staff of basic concepts)",
                            "level3": "Competent (Digital Literacy strengthening is part of a training program)",
                            "level4": "Advanced (Continuous capacity building framework Digital Literacy in place)",
                            "level5": "Expert (Health staff and leadership develop functionally in the information society)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Key concepts knowledge levels are:",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Open government ",
                            "level1": "Beginner",
                            "level2": "Developing (awareness among leadership and staff of basic concepts)",
                            "level3": "Competent (concept strengthening is part of a training program)",
                            "level4": "Advanced (Continuous capacity building framework includes concept)",
                            "level5": "Expert (Health staff and leadership incorporate functionally their conceptual knowledge in their routine activities)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Big data",
                            "level1": "Beginner",
                            "level2": "Developing (awareness among leadership and staff of basic concepts)",
                            "level3": "Competent (concept strengthening is part of a training program)",
                            "level4": "Advanced (Continuous capacity building framework includes concept)",
                            "level5": "Expert (Health staff and leadership incorporate functionally their conceptual knowledge in their routine activities)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Internet of Things",
                            "level1": "Beginner",
                            "level2": "Developing (awareness among leadership and staff of basic concepts)",
                            "level3": "Competent (concept strengthening is part of a training program)",
                            "level4": "Advanced (Continuous capacity building framework includes concept)",
                            "level5": "Expert (Health staff and leadership incorporate functionally their conceptual knowledge in their routine activities)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Data management and governance",
                            "level1": "Beginner",
                            "level2": "Developing (awareness among leadership and staff of basic concepts)",
                            "level3": "Competent (concept strengthening is part of a training program)",
                            "level4": "Advanced (Continuous capacity building framework includes concept)",
                            "level5": "Expert (Health staff and leadership incorporate functionally their conceptual knowledge in their routine activities)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Open data",
                            "level1": "Beginner",
                            "level2": "Developing (awareness among leadership and staff of basic concepts)",
                            "level3": "Competent (concept strengthening is part of a training program)",
                            "level4": "Advanced (Continuous capacity building framework includes concept)",
                            "level5": "Expert (Health staff and leadership incorporate functionally their conceptual knowledge in their routine activities)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Health Analysis for Decision-Making::A systematic approach for health needs assessments; accessibility of essential information; advanced analytical techniques to support real time clinical, management, policy and decision making.",
                            "level1": "Standard statistical analysis is routinely applied to available health data to generate reports on health status and outcomes. Most health analysis is focused on the generation of indicators, although other types of health analysis are done on an ad hoc basis are required for special presentations and projects. Information is used to support decision-making in limited circumstances, but evidence-informed decision making is integrated into the policy and management culture.",
                            "level2": "Data typically flows from sources to central decision-makers for health analysis, but little health information is available for decision-making at the local level. There is evidence that data and information are routinely used to support policy and management decision-making.",
                            "level3": "All essential information to support clinical, management, policy decision-making and is readily accessible, and end-users have on-demand access to information products or health analysis resources.There is capability among clinicians, administrators, and policy-makers for evidence-informed decision-making, and clinical, management and policy decisions are data-driven. A range of defined health analysis approaches are routinely applied (e.g., ASIS ARMAR7, Health Inequalities, Multiple Cause of Death Analysis, etc.).",
                            "level4": "There is advanced capacity among technical staff. Continuous capacity building (investment in skills, tools, partnerships) for more advanced approaches of health analysis ",
                            "level5": "There is expert knowledge and capacity among technical staff that go beyond routine analysis required. There is annual capacitation and budget towards training.  Health Analysis can be done real-time and routine clinical, management and policy decision-making are based on timely analysis. Data driven decision-making. for public health strategies and activities.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Staff skills and knowledge to analyze the data are:",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Descriptive analysis",
                            "level1": "No knowledge or beginner ",
                            "level2": "Developing (awareness of the key concepts among leadership and staff)",
                            "level3": "Competent (health analysis skills strengthening is part of a training program)",
                            "level4": "Advanced (Continuous capacity building framework on health analysis in place)",
                            "level5": "Expert (Health staff and leadership incorporate health analysis in their routine activities)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Inferential statistics",
                            "level1": "No knowledge or beginner ",
                            "level2": "Developing (awareness of the key concepts among leadership and staff)",
                            "level3": "Competent (health analysis skills strengthening is part of a training program)",
                            "level4": "Advanced (Continuous capacity building framework on health analysis in place)",
                            "level5": "Expert (Health staff and leadership incorporate health analysis in their routine activities)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Data visualization and exploratory data analysis",
                            "level1": "No knowledge or beginner ",
                            "level2": "Developing (awareness of the key concepts among leadership and staff)",
                            "level3": "Competent (health analysis skills strengthening is part of a training program)",
                            "level4": "Advanced (Continuous capacity building framework on health analysis in place)",
                            "level5": "Expert (Health staff and leadership incorporate health analysis in their routine activities)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Public health modeling",
                            "level1": "No knowledge or beginner ",
                            "level2": "Developing (awareness of the key concepts among leadership and staff)",
                            "level3": "Competent (health analysis skills strengthening is part of a training program)",
                            "level4": "Advanced (Continuous capacity building framework on health analysis in place)",
                            "level5": "Expert (Health staff and leadership incorporate health analysis in their routine activities)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Data science:  Predictive analysis based on machine learning, deep learning neural networks; clustering, anomaly, association rule mining, prediction",
                            "level1": "No knowledge or beginner ",
                            "level2": "Developing (awareness of the key concepts among leadership and staff)",
                            "level3": "Competent (health analysis skills strengthening is part of a training program)",
                            "level4": "Advanced (Continuous capacity building framework on health analysis in place)",
                            "level5": "Expert (Health staff and leadership incorporate health analysis in their routine activities)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Health analysis approaches are applied",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Descriptive (summary) analysis",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do but not routinely",
                            "level3": "Some facilities/units/teams do routinely",
                            "level4": "Fully implemented at the public health system",
                            "level5": "Yes, fully implemented at the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Inferential statistics",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do but not routinely",
                            "level3": "Some facilities/units/teams do routinely",
                            "level4": "Fully implemented at the public health system",
                            "level5": "Yes, fully implemented at the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Data visualization and exploratory data analysis",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do but not routinely",
                            "level3": "Some facilities/units/teams do routinely",
                            "level4": "Fully implemented at the public health system",
                            "level5": "Yes, fully implemented at the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Public health modeling",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do but not routinely",
                            "level3": "Some facilities/units/teams do routinely",
                            "level4": "Fully implemented at the public health system",
                            "level5": "Yes, fully implemented at the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Data science:  Predictive analysis based on machine learning, deep learning neural networks; clustering, anomaly, association rule mining, prediction",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do but not routinely",
                            "level3": "Some facilities/units/teams do routinely",
                            "level4": "Fully implemented at the public health system",
                            "level5": "Yes, fully implemented at the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "National Health Sector Strategic plan is based on data driven situation analysis",
                            "level1": "there is not current national health sector strategic plan",
                            "level2": "there is a current nat. Health sector strategic plan but data is not recent",
                            "level3": "there is a current nat. Health sector strategic plan",
                            "level4": "there is a current nat. health sector strategic plan, accessible online, which includes trend analysis ",
                            "level5": "there is a current nat. health sector strategic plan, accessible online, which includes trend analysis and burden of disease analysis and health systems strength analysis",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Health analysis available allow prioritization, monitoring and evaluation ",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Causes of Death analysis",
                            "level1": "irregular and isolated analysis are available but do not allow prioritization ",
                            "level2": "isolated and irregular analysis are done, which are used for prioritization ",
                            "level3": "analysis institutionalized but not implemented that would allow continuous prioritization/M&E ",
                            "level4": "institutionalized and implemented that allow continuous prioritization/M&E but operationally issues exist (representativeness, timeliness)",
                            "level5": "Health analysis to identify vulnerable populations at national, subnational and local level are done for monitoring and targeting interventions (data flow, timeliness, representativeness optimal)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Live births analysis",
                            "level1": "irregular and isolated analysis are available but do not allow prioritization ",
                            "level2": "isolated and irregular analysis are done, which are used for prioritization ",
                            "level3": "analysis institutionalized but not implemented that would allow continuous prioritization/M&E ",
                            "level4": "institutionalized and implemented that allow continuous prioritization/M&E but operationally issues exist (representativeness, timeliness)",
                            "level5": "Health analysis to identify vulnerable populations at national, subnational and local level are done for monitoring and targeting interventions (data flow, timeliness, representativeness optimal)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Maternal and neonatal mortality analysis",
                            "level1": "irregular and isolated analysis are available but do not allow prioritization ",
                            "level2": "isolated and irregular analysis are done, which are used for prioritization ",
                            "level3": "analysis institutionalized but not implemented that would allow continuous prioritization/M&E ",
                            "level4": "institutionalized and implemented that allow continuous prioritization/M&E but operationally issues exist (representativeness, timeliness)",
                            "level5": "Health analysis to identify vulnerable populations at national, subnational and local level are done for monitoring and targeting interventions (data flow, timeliness, representativeness optimal)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Non Communicable Diseases  analysis",
                            "level1": "irregular and isolated analysis are available but do not allow prioritization ",
                            "level2": "isolated and irregular analysis are done, which are used for prioritization ",
                            "level3": "analysis institutionalized but not implemented that would allow continuous prioritization/M&E ",
                            "level4": "institutionalized and implemented that allow continuous prioritization/M&E but operationally issues exist (representativeness, timeliness)",
                            "level5": "Health analysis to identify vulnerable populations at national, subnational and local level are done for monitoring and targeting interventions (data flow, timeliness, representativeness optimal)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Communicable Diseases analysis",
                            "level1": "irregular and isolated analysis are available but do not allow prioritization ",
                            "level2": "isolated and irregular analysis are done, which are used for prioritization ",
                            "level3": "analysis institutionalized but not implemented that would allow continuous prioritization/M&E ",
                            "level4": "institutionalized and implemented that allow continuous prioritization/M&E but operationally issues exist (representativeness, timeliness)",
                            "level5": "Health analysis to identify vulnerable populations at national, subnational and local level are done for monitoring and targeting interventions (data flow, timeliness, representativeness optimal)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Vaccine preventable diseases analysis",
                            "level1": "irregular and isolated analysis are available but do not allow prioritization ",
                            "level2": "isolated and irregular analysis are done, which are used for prioritization ",
                            "level3": "analysis institutionalized but not implemented that would allow continuous prioritization/M&E ",
                            "level4": "institutionalized and implemented that allow continuous prioritization/M&E but operationally issues exist (representativeness, timeliness)",
                            "level5": "Health analysis to identify vulnerable populations at national, subnational and local level are done for monitoring and targeting interventions (data flow, timeliness, representativeness optimal)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Risk factors",
                            "level1": "irregular and isolated analysis are available but do not allow prioritization ",
                            "level2": "isolated and irregular analysis are done, which are used for prioritization ",
                            "level3": "analysis institutionalized but not implemented that would allow continuous prioritization/M&E ",
                            "level4": "institutionalized and implemented that allow continuous prioritization/M&E but operationally issues exist (representativeness, timeliness)",
                            "level5": "Health analysis to identify vulnerable populations at national, subnational and local level are done for monitoring and targeting interventions (data flow, timeliness, representativeness optimal)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Health Systems and Coverage analysis",
                            "level1": "irregular and isolated analysis are available but do not allow prioritization ",
                            "level2": "isolated and irregular analysis are done, which are used for prioritization ",
                            "level3": "analysis institutionalized but not implemented that would allow continuous prioritization/M&E ",
                            "level4": "institutionalized and implemented that allow continuous prioritization/M&E but operationally issues exist (representativeness, timeliness)",
                            "level5": "Health analysis to identify vulnerable populations at national, subnational and local level are done for monitoring and targeting interventions (data flow, timeliness, representativeness optimal)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Health analysis is focused on",
                            "level1": "Descript of current health situation",
                            "level2": "Descript of current health situation; Cases detection",
                            "level3": "Description of current health situation, detect, monitor",
                            "level4": "Descript, detect, monitor, raise awareness, and past trends",
                            "level5": "Descript, detect, monitor, raise awareness and provide insights, past trends and forecasting",
                            "runtimeType": "question"
                        },
                        {
                            "text": "The organization has a formal mechanism for human resources development on health analysis",
                            "level1": "No",
                            "level2": "No formal mechanism: Some facilities/units/teams encourage their HR for development but is not formalized and is based on individual commitment",
                            "level3": "In process of implementation in entire institution that Health analysis training is  included in HR policy.",
                            "level4": "Yes, but not fully implemented, implementation plan, effective resources allocation, etc.",
                            "level5": "Yes, fully implemented and resourced and staff is continuously trained",
                            "runtimeType": "question"
                        },
                        {
                            "text": "The organization has a formal mechanism for human resources development on information systems for health",
                            "level1": "No",
                            "level2": "Some facilities/units/teams encourage their HR for development but is not formalized and is based on individual commitment",
                            "level3": "In process of implementation in entire institution, IS4H development mechanism is being included into the HR policy.",
                            "level4": "Yes, but not fully implemented, implementation plan, effective resources allocation, etc.",
                            "level5": "Yes, fully implemented and resourced and staff is continuously trained",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Uses of non-conventional databases (e.g. emergency calls, absence in school, etc.) to support decision-making in public health",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do but not routinely",
                            "level3": "Some facilities/units/teams do routinely",
                            "level4": "Fully implemented at the public health system",
                            "level5": "Yes, fully implemented at the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Tools::Health analysis and business intelligence tools are available for advanced approaches to health information. ",
                            "level1": "Basic tools are routinely used for health analysis (e.g., spreadsheets, MS Access, etc.)  ",
                            "level2": "Basic tools are routinely used for health analysis (e.g., spreadsheets, statistical packages, etc.) and data is stored in relational databases",
                            "level3": "Advanced tools are routinely used for health analysis (e.g., spreadsheets, statistical packages, etc.) and all data is stored in relational databases",
                            "level4": "Advanced tools are routinely used for health analysis (e.g., spreadsheets, statistical packages, etc.) and all data is stored in relational databases and new approaches for non traditional databases are initiated., tools are continuously updated and improved. Online data platform are available.",
                            "level5": "Online tools and platforms for data dissemination and analysis (e.g., data repositories, dashboards, portals, visualization tools, spatial data, etc.) are appropriately and securely available for different user types, such as policy makers, manager, clinicians, and public stakeholders ",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Tools used to support health analysis",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Spreadsheets (Excel)",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine.",
                            "level4": "Yes, is the standardized and interoperable health analysis tool used among public health system",
                            "level5": "Yes, is the standardized and interoperable health analysis tool used among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Data analytics tools (SPSS, SAS, R)",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine.",
                            "level4": "Yes, is the standardized and interoperable health analysis tool used among public health system",
                            "level5": "Yes, is the standardized and interoperable health analysis tool used among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Business intelligence tools and dashboards (e.g. Tableau)",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine.",
                            "level4": "Yes, is the standardized and interoperable health analysis tool used among public health system",
                            "level5": "Yes, is the standardized and interoperable health analysis tool used among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Geographic information systems (ArcGIS)",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine.",
                            "level4": "Yes, is the standardized and interoperable health analysis tool used among public health system",
                            "level5": "Yes, is the standardized and interoperable health analysis tool used among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Database management systems used",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "MS SQL",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine.",
                            "level4": "Yes, is the standardized and interoperable health analysis system used among public health system",
                            "level5": "Yes, is the standardized and interoperable health analysis tool used among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "MS Access",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine.",
                            "level4": "Yes, is the standardized and interoperable health analysis system used among public health system",
                            "level5": "Yes, is the standardized and interoperable health analysis tool used among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Open source: Posgres SQL/Linux/MySQL",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine.",
                            "level4": "Yes, is the standardized and interoperable health analysis system used among public health system",
                            "level5": "Yes, is the standardized and interoperable health analysis tool used among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Oracle Database",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine.",
                            "level4": "Yes, is the standardized and interoperable health analysis system used among public health system",
                            "level5": "Yes, is the standardized and interoperable health analysis tool used among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Open source: Hadoop/Apache",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine.",
                            "level4": "Yes, is the standardized and interoperable health analysis system used among public health system",
                            "level5": "Yes, is the standardized and interoperable health analysis tool used among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Programming languages used",
                            "questions": [],
                            "runtimeType": "subGroup"
                        },
                        {
                            "text": "Java",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine, with their own selection criteria.",
                            "level4": "Yes, is the standardized and interoperable language used among public health system",
                            "level5": "Yes, standardized and interoperable among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "PHP",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine, with their own selection criteria.",
                            "level4": "Yes, is the standardized and interoperable language used among public health system",
                            "level5": "Yes, standardized and interoperable among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Ruby",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine, with their own selection criteria.",
                            "level4": "Yes, is the standardized and interoperable language used among public health system",
                            "level5": "Yes, standardized and interoperable among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "C++",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine, with their own selection criteria.",
                            "level4": "Yes, is the standardized and interoperable language used among public health system",
                            "level5": "Yes, standardized and interoperable among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "R, Python",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do randomly",
                            "level3": "Some facilities/units/teams do as part of their routine, with their own selection criteria.",
                            "level4": "Yes, is the standardized and interoperable language used among public health system",
                            "level5": "Yes, standardized and interoperable among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Data warehouse (DWH) within the organization exists",
                            "level1": "No",
                            "level2": "An institutional DWH is in development but not operational",
                            "level3": "Institutional DWH exists but not regularly updated",
                            "level4": "Institutional DWH is updated, online access ",
                            "level5": "A national DWH is updated, sustainable, easy access, full documentation and data can be shared across national, subnational and local levels",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Organization disseminates data/information/analysis through ",
                            "level1": "Internal reports, documents within organization",
                            "level2": "Printed, online in pdf",
                            "level3": "Printed, online interactive",
                            "level4": "Printed, online/interactive, vis tools/dashboards",
                            "level5": "All 3 with  open data portal",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Digital Health::Digital health tools being used to transform models of care, improve patient safety, quality of care and supporting population health approaches. Health care and service are delivered virtually.                                                                                                                                                                                                                     ",
                            "level1": "Health care delivery and services are largely manual processes. Assessing digital technologies in health incl health information systems at national/subnational level to identify areas of improvement",
                            "level2": "Digital health tools such as electronic records, laboratory/pharmacy information systems and electronic order entry are being implemented with a focus digitizing manual processes and operational efficiencies.  Developed roadmap based on assessment to better integrate digital technologies into existing health systems including  normative and technical aspects",
                            "level3": "There is evidence of digital health tools being used to transform models of care, improve patient safety and quality of care, or for supporting population health approaches.  Appropriate legislation and data protection policies around data access, sharing, consent, security, privacy, interoperability are being developed",
                            "level4": "Digital health tools are used to facilitate targeted communications to individuals to stimulate demand for services/access to health information and digital health interventions are targeted to health workers to give them immediate access to improve decision support mechanisms /telemedicine ",
                            "level5": "•",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Current digital health initiatives ",
                            "level1": "Some isolated and fragmented, stand alone ICT solutions",
                            "level2": "At the local level Digital Health initiatives are developed or adopted with no consideration of interoperability and IT standards issues. ",
                            "level3": "Starting to improve/plan a integrated digital health environment. Integration of local initiatives in progress.",
                            "level4": "Yes, tools are developed, adopted considering standards and interoperability among public health system",
                            "level5": "Standardized and interoperable among the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Development of national digital health policy and strategies",
                            "level1": "The government plans specific digitalization actions, not focused on health, led by the technology ministry or the counterpart, such as ensuring connectivity with bandwidth according to the population size of the different places",
                            "level2": "The country has a digital strategy that does not include specific health actions led by the technology ministry or the counterpart.",
                            "level3": "The country has a specific digital strategy for health. The Ministry (authorities) of Health leads the digitalization of the health system, with actions such as the elaboration of plans for the implantation of EMR",
                            "level4": "The country has a specific digital health strategy with a multi-year budget",
                            "level5": "The country has a specific digital health strategy that is aligned with the general digital strategy and has a multi-year budget",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Telemedicine - patient to provider is a complement, not replacing person in person care",
                            "level1": "not on the agenda",
                            "level2": "Some isolated initiatives at the local level, most based on reference and counter reference",
                            "level3": "Under development of a telemedicine network in the entire country",
                            "level4": "In process of implementation through all the institution",
                            "level5": "fully developed, network exists",
                            "runtimeType": "question"
                        },
                        {
                            "text": "E-Government::Integration of the health sector on the eGovernment initiatives, including the adoption of standards, applications, and information services to transform transactions between government and the public, businesses, or other organizations in health. ",
                            "level1": "E-government is not on the national agenda.",
                            "level2": "E-government is on the national agenda, but there is no formal strategy or unit in place.",
                            "level3": "The government has established an e-government strategy or unit.  Currently the focus is on strengthening core IT infrastructure.  Health is not a core stakeholder.",
                            "level4": "There is evidence of eGovernment initiatives that are transforming transactions between government and the public, businesses, or other organizations in health (e.g. online appointment booking, patient portals, e-referral, health card registration, etc.)",
                            "level5": "The health sector is fully integrated into e-government initiatives and platforms.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "E-government is on the national agenda (Citizens interaction with government)",
                            "level1": "No",
                            "level2": "basic services are provided with e-government but not for health sector ",
                            "level3": "streamlined services are provided with e-government including health sector (Can have some interactions or communications) ",
                            "level4": "e-government is  implemented for the provision of public services to citizens and businesses and the health care sector ",
                            "level5": "e-government is well implemented for the provision of public services to citizens and businesses that includes health care",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Current e-government focus is on",
                            "level1": "Not clear",
                            "level2": "Strengthening core IT infrastructure",
                            "level3": "Strengthening administrative process like procurement, budget, etc. Also including IT infrastructure",
                            "level4": "Strengthening management process through administrative and IT infrastructure including health sector",
                            "level5": "Transactions and relation with the public including health sector is fully implemented",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Level of integration of national health authorities in e-government initiatives",
                            "level1": "Not a core stakeholder",
                            "level2": "Slightly, health is ad hoc invited to some particular events",
                            "level3": "Moderately: in process of integrating health",
                            "level4": "Very: is a core stakeholder",
                            "level5": "Health is integrated in eGov initiative with continuous improvement of the sector",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Integration of Health specific public portals or health e-service with the national e-government platform ",
                            "level1": "No public e-services",
                            "level2": "Public health e-services are available, but separate from e-government platform and services",
                            "level3": "Some isolated public health e-services from facilities facilities/units/teams are integrated with national e-government platform",
                            "level4": "Yes, Public health e-services are  integrated but not with all sectors/stakeholders (correct statement?)",
                            "level5": "Yes, Public health e-services are fully integrated with national e-government platform (e.g. single point of entry; single sign-on)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Open Government::Public access and effective oversight to government documents and proceedings. Open Data principles application and data sets availability. ",
                            "level1": "The concepts of Open Government are new to leadership.",
                            "level2": "There is broad knowledge of open government principles among national health authorities, and leadership support for advancing open government policies and initiatives.",
                            "level3": "Open data principles have been formally adopted in policy. ",
                            "level4": "Open data principles are fully applied, and key data sets are available for analysis by other national and international stakeholders.",
                            "level5": "Open data principles are fully applied, and key data sets are available for analysis by other national and international stakeholders.",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Leadership and staff knowledge of Open Government concepts and principles",
                            "level1": "Beginner (a few knowledge)",
                            "level2": "Developing (awareness among leadership and staff of the key concepts)",
                            "level3": "Competent (Open Government skills strengthening is part of a training program)",
                            "level4": "Advanced (Continuous capacity building framework on Open Government in place)",
                            "level5": "Expert (Health staff and leadership incorporate functionally their Open Government Knowledge in their routine activities)",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There is leadership support for advancing open government policies and initiatives",
                            "level1": "Not at all ",
                            "level2": "Slightly",
                            "level3": "Moderately",
                            "level4": "Very",
                            "level5": "Extremely",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There is open data policy in government",
                            "level1": "no",
                            "level2": "some policies/units/areas do as part of their institutional processes  ",
                            "level3": " Formal process under development in the entire organization",
                            "level4": "Yes, documented and implemented at national levels",
                            "level5": "Yes,  documented and implemented at the facility, region and national levels",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Principles of “openness” integrated into organizational policy ",
                            "level1": "No",
                            "level2": "Principles of openness are aware but not part of policies",
                            "level3": "Some aspects of open data/open governance are reflected in policy, but not all;",
                            "level4": "Yes, there are some isolated policies or processes that reflect the principals of openness;",
                            "level5": "Yes, policy integrates principles of “openness ”throughout organization",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Preparedness and Resilience::Capacity of the information systems for health to operate during and after emergencies and disasters requires the development and application of special operating procedures to ensure access to the right information at the right moment in the right format. ",
                            "level1": "Manual and electronic health information systems are vulnerable to failure in the event of a natural disaster or other catastrophic event. Limited data available to support disaster response.",
                            "level2": "There is evidence of approaches for ensuring business continuity in the case of disaster (e.g., routine off-site backups, downtime manual process SOPs, etc.).Some key data sets are available to support disaster response (e.g., facilities and health human resource databases, database of emergency centers, mortality data, etc.)",
                            "level3": "There is evidence that essential health information systems would continue working during disasters and will be able to able to support some health system functions and disaster response.",
                            "level4": "Health information systems would be resilient during disasters and are able to able to support essential health system functions and disaster response.",
                            "level5": "Health information systems are  resilient during disasters and are able to able to support essential health system functions and disaster response",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There is a plan for health information recovery",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do but not routinely",
                            "level3": "Some facilities/units/teams do routinely",
                            "level4": "Fully implemented at the public health system",
                            "level5": "Yes, fully implemented at the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There is a contingency plan to ensure basic IS4H functionality in case of emergency or disasters",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do but not routinely",
                            "level3": "Some facilities/units/teams do routinely",
                            "level4": "Fully implemented at the public health system",
                            "level5": "Yes, fully implemented at the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Key data sets are available to support disaster response",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do but not routinely",
                            "level3": "Some facilities/units/teams do routinely",
                            "level4": "Fully implemented at the public health system",
                            "level5": "Yes, fully implemented at the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "There is a Data Backup Strategy",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do but not routinely",
                            "level3": "Some facilities/units/teams do routinely",
                            "level4": "Fully implemented at the public health system",
                            "level5": "Yes, fully implemented at the national health system",
                            "runtimeType": "question"
                        },
                        {
                            "text": "Health information systems can support essential health system functions and disaster response",
                            "level1": "No",
                            "level2": "Some facilities/units/teams do but not routinely",
                            "level3": "Some facilities/units/teams do routinely",
                            "level4": "Fully implemented at the public health system",
                            "level5": "Yes, fully implemented at the national health system",
                            "runtimeType": "question"
                        }
                    ]
                }
            ]
        }
    ]
});