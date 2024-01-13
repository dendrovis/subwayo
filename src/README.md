# CZ3005 Subway Sandwich Interactor
## What is it?
An subway sandwich interactor interactive interface prototype using prolog and javascript (web-based).
## The Motivation
There has been a pandemic disease going throughout the world also known as “COVID-19”. In Singapore, the daily new cases who are tested positive for “COVID-19” are exponentially on the rise. There has been increasing concern where doctors and nurses who are the frontline of the battle against this disease, as they will be the most vulnerable to get an infection as the demand for hospitalization increases. The government has suggested a few ideas to mitigate this concern. One of the project titles called “Subway sandwich interactor” which collaborates with SUBWAY; an American privately held restaurant franchise that primarily sells submarine sandwiches and salads. It is one of the ways to reduce interaction between vendors and customer especially the doctors and nurses. This product helps retain SUBWAY business while upholding the social distancing measures. This product will be implemented throughout Singapore hospitals.
## Installation
1. Access to download site of prolog https://www.swi-prolog.org/download/stable
2. Select and Install **SWI-Prolog** (recommended **version 8.0.3-1** and above) base on operating system platform.
3. Navigate to downloaded directory.
4. Install **swipl-8.0.3-1** execute file.
## How to run?
### For Prolog Only Ver
1. Extract **CZ3005_Subway_Sandwich_Interactor-master.zip** file into a working directory folder.
2. Double click and navigate into **SSI_PrologOnly** folder.
3. Open and Execute **SSI_KBS.pl** file .
4. If it is not executeable due to path binding then right click -> open with -> navigate to install prolog execute program. (Default execute prolog file should be **C:/Program Files/swipl/bin/swipl-win.exe**).
5. Once run, the prolog interface must be visible.
6. Type **'run.'** and enter to run the program.
7. Type **'abort.'** and enter to abort the program.
8. User must **key in the options** to continue. **Accpetable options** for example : 'Veggie Delite', 'veggiedelite'. Options can be **y/n** or the **options given** from the question.
### For Prolog + Javascript (Web) Ver
1. Extract **CZ3005_Subway_Sandwich_Interactor.zip** file into a working directory folder.
2. Double click and navigate into SSI_Prolog_Web folder.
3. Open and Execute **SSI_Run.pl** file.
5. If it is not executeable due to path binding then right click -> open with -> navigate to install prolog execute program. (Default execute prolog file should be **C:/Program Files/swipl/bin/swipl-win.exe**).
6. Once run, the prolog interface must be visible.
7. Type **'run.'** and enter to fired up the server.
8. Launch **google chrome browser**. 
9. At the URL and type **'localhost:880'** and enter.
10. Click on the images and button to interact with the program.

## Software Architecture Design for Prolog + Javascript (Web) Ver
This program mainly utilize and adapt using prolog pengines package. This package provides a powerful high-level programming abstraction implemented on top of SWI-Prolog's thread predicates and its HTTP client and server libraries. The package makes it easy to create and query Prolog engines (or Pengines for short), over HTTP, from an ordinary Prolog thread, from a pengine, or from JavaScript running in a web client. Querying follows Prolog's default one-tuple-at-a-time generation of solutions. I/O is also supported.
- References : https://pengines.swi-prolog.org/docs/index.html

## Features
### For Prolog Only Ver
- **JSON** was serve as a database environment.
- Prolog program fetch instruction from database is it possible with the help of this library -> use_module(library(http/json)).
- This setup allow database to archive **scalability** , for example if more menu is added/remove, it can be done without much distruption on run-time process.
- **Dialog** interaction of the program representation.

### For Prolog + Javascript (Web) Ver
- Utilize pengine and server libraries offer by prolog to allow support **javascript** integrated into the system.
- It allow the benefits of **server and client** software architecture.
- It has **voice assist** to read the queries.
- Pengine consist of javascript and prolog API allow easy **manipulation**.
- **Visual interaction** of the program representation.

## Development
The development was started off with pure prolog to understand the basic of logic programming such as the terms, facts and rules. The goal was get basic dialog logic setup and to achieve possible of dynamic data access with data fetching from JSON as dynamic memory. Using JSON as database as a example in this prototype. After prolog development is done, the next ambitious archievement was to setup a web-based development. This lead to the discovery of pengine and their utilities and server setup and etc. The goal of web-based was to understand how prolog use logic programming on web development and explore the possibility prolog can offer. All in all, prolog is well-suited for specific tasks that benefit from rule-based logical queries such as searching databases, voice control systems, and filling templates. This lab assessment has serve it's requirement, eventhough it is far from perfection. Nonetheless this assessment has set a foundation for future development especially the field of aritifical intelligent (AI).

## Disclaimer
The story information provided by me on this document is makeup base on certain facts of the real world, however, I make no representation or warranty of any kind, express or implied, regarding the accuracy, adequacy, validity, reliability, availability or completeness or any information provided in this documentation. This document is meant for assessment and educational purposes only.

## About the Developer and Lab Assessment
#### Author :             Sam Jian Shen 
#### Class :              TS4
#### Assessment Title :   Subway Sandwich Interactor 
#### Assignment Index :   Lab 3, Assignment - 3 
#### Module Code :        CZ3005

## Version(Alpha)
0.1