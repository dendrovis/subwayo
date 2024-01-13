% ------------------------------------------------------------------------------------------------
% Author :             Sam Jian Shen 
% Class :              TS4
% Assessment Title :   Subway Sandwich Interactor 
% Assignment Index :   Lab 3, Assignment - 3 
% Module Code :        CZ3005
% Version :            0.1 
% ------------------------------------------------------------------------------------------------
% ------------------------------------------------------------------------------------------------
% Command Usage
% - Admin are allowed to terminate option by key in 'abort'.
% - Food options are either key in by y/n or respective option name.
% - Option name disregard spacing, casing (For example, 'Veggie Delite', 'veggiedelite', both are acceptable option).
% - Reading user input is depend on line not term.
% ------------------------------------------------------------------------------------------------
% ------------------------------------------------------------------------------------------------
% Assumption :
% - All (food name/element of the list) is unique.
% ------------------------------------------------------------------------------------------------
% ------------------------------------------------------------------------------------------------
% Initialization and Facts Formulation
% ------------------------------------------------------------------------------------------------
% Define Working Directory
% :- working_directory(_, '/SSI_PrologOnly'),
%    print("Set Working Directory Successfully"),nl.

% Define Read Enabled For JSON
:- use_module(library(http/json)),
    print("Initialize System Library Usage Successfully"),nl.

% Store the options chosen by user
:- dynamic orderOption/1.
:- dynamic mealOption/1.
:- dynamic promotionOption/1.
:- dynamic classicOption/1.
:- dynamic sandwichOption/1.
:- dynamic meatOption/1.
:- dynamic saladOption/1.
:- dynamic sauceOption/1.
:- dynamic topupOption/1.
:- dynamic sideOption/1.
:- dynamic paymentOption/1.

% Clear All Dynamic Memory/Facts
:- 
   retractall(meal(_,_)),
   retractall(custom(_,_)),
   retractall(topup(_)),
   retractall(side(_)),
   retractall(price(_,_)),
   retractall(perferences(_,_)),
   print("Clear Dynamic Memory of Database Facts Successully"),nl.

clearUserOption :- 
    retractall(mealOption(_)),
    retractall(promotionOption(_)),
    retractall(classicOption(_)),
    retractall(sandwichOption(_)),
    retractall(meatOption(_)),
    retractall(saladOption(_)),
    retractall(sauceOption(_)),
    retractall(topupOption(_)),
    retractall(sideOption(_)),
    retractall(paymentOption(_)),
    retractall(orderOption(_)),
    print("Clear Dynamic Memory of User Facts Successully"),nl.


% Read Data From JSON To Formulate Facts 
get_dict_from_json_file(Key,Value) :- 
    FPath = 'SSI_DB.json',
    open(FPath, read, Stream), 
    json_read_dict(Stream, Data), 
    close(Stream),  
    get_dict(Key,Data,Value),                                % Syntax : get_dict(Key,JSON Data, Value)
    format("\"Data Retrived <~w> From Database Successfully\"",[Key]),nl.

% Learn the price of each element of food.
assertzPrice([],[]).                                         % return true if both list is empty
assertzPrice([A|B],[C|D]) :- 
    assertz(price(A,C)),                                     % learn the the head of the both list
    assertzPrice(B,D).                                       % recurvise for the remainder of the lists

    % Logic : Key -> Value(Key of ValueL2) -> ValueL2 -> etc (Base on JSON DB)
:-  
    get_dict_from_json_file(meal,ValueM),                    % get meal key 
    get_dict_from_json_file(custom,ValueCu),                 % get custom key 
    get_dict_from_json_file(top_up,ValueT),                  % get top_up key
    get_dict_from_json_file(side,ValueS),                    % get side key
    get_dict_from_json_file(perferences,ValueP),             % get perferences key

    get_dict(promotion,ValueM,ValuePromotion),               % get promotion key
    get_dict(classic,ValueM,ValueClassic),                   % get classic key
    get_dict(sandwich,ValueCu,ValueSandwich),                % get sandwich key
    get_dict(meat,ValueCu,ValueMeat),                        % get meat key
    get_dict(salad,ValueCu,ValueSalad),                      % get salad key
    get_dict(sauce,ValueCu,ValueSauce),                      % get sauce key
    get_dict(vegan,ValueP,ValueVegan),                       % get vegan key
    get_dict(healthy,ValueP,ValueHealthy),                   % get healthy key

    get_dict(name,ValuePromotion,Promotion_NList),           % get name of promotion key
    get_dict(price,ValuePromotion,Promotion_PList),          % get price of promotion key
    get_dict(name,ValueClassic,Classic_NList),               % get name of classic key
    get_dict(price,ValueClassic,Classic_PList),              % get price of classic key
    get_dict(name,ValueSandwich,Sandwich_NList),             % get name of sandwich key
    get_dict(price,ValueSandwich,Sandwich_PList),            % get price of sandwich key
    get_dict(name,ValueMeat,Meat_NList),                     % get name of meat key
    get_dict(price,ValueMeat,Meat_PList),                    % get price of meat key
    get_dict(name,ValueSalad,Salad_NList),                   % get name of salad key
    get_dict(price,ValueSalad,Salad_PList),                  % get price of salad key
    get_dict(name,ValueSauce,Sauce_NList),                   % get name of sauce key
    get_dict(price,ValueSauce,Sauce_PList),                  % get price of sauce key
    get_dict(name,ValueT,TopUp_NList),                       % get name of top_up key
    get_dict(price,ValueT,TopUp_PList),                      % get price of top_up key
    get_dict(name,ValueS,Side_NList),                        % get name of side key
    get_dict(price,ValueS,Side_PList),                       % get price of side key

    assertz(meal(promotion,Promotion_NList)),                % Learn Promotion name Facts 
    assertz(meal(classic,Classic_NList)),                    % Learn Classic name Facts
    assertz(custom(sandwich,Sandwich_NList)),                % Learn Sandwich name Facts 
    assertz(custom(meat,Meat_NList)),                        % Learn Meat name Facts
    assertz(custom(salad,Salad_NList)),                      % Learn Salad name Facts  
    assertz(custom(sauce,Sauce_NList)),                      % Learn Sauce name Facts
    assertz(topup(TopUp_NList)),                             % Learn TopUp name Facts
    assertz(side(Side_NList)),                               % Learn Side name Facts
    assertz(perferences(vegan,ValueVegan)),                  % Learn Vegan Facts
    assertz(perferences(healthy,ValueHealthy)),              % Learn Healthy Facts

    assertzPrice(Promotion_NList,Promotion_PList),           % Learn the prices of individual food elements
    assertzPrice(Classic_NList,Classic_PList),
    assertzPrice(Sandwich_NList,Sandwich_PList),
    assertzPrice(Meat_NList,Meat_PList),
    assertzPrice(Sauce_NList,Sauce_PList),
    assertzPrice(Salad_NList,Salad_PList),
    assertzPrice(TopUp_NList,TopUp_PList),
    assertzPrice(Side_NList,Side_PList),

    print("Facts Inserted Into Knowledge-Base System(KBS) From Database Successfully"),nl.

% ------------------------------------------------------------------------------------------------
% Inital True Facts
% ------------------------------------------------------------------------------------------------
order([meal,custom]).
perferences([vegan,healthy]).
meal([promotion,classic]).
custom([sandwich,meat,salad,sauce]).
payment([cash,credit_card]).
% ------------------------------------------------------------------------------------------------
% Listing Initial Facts
% ------------------------------------------------------------------------------------------------
:-  
    print("Listing Learnt Facts..."),nl,
    listing(meal),                                                      % List Classic Meal  Facts 
    listing(custom),                                                    % List Promotion Meal  Facts 
    listing(topup),                                                     % List TopUp  Facts
    listing(side),                                                      % List Side  Facts
    listing(perferences),                                               % List Perferences Facts
    listing(price).                                                     % List Price Facts          
% ------------------------------------------------------------------------------------------------
% Rules
% - The User that select 'vegan' as perferences must not be able to choose meat option
% - The User that select 'healthy' as perferences must have reduce specific options (like bacon for example)
% - The User that select 'none' must display all possible option given from the database
% - The User that select not('none') as perferences must have reduce specific options compare to 'none' perferences
% ------------------------------------------------------------------------------------------------
% print the list
showList([]).                                                           % return when the list is empty
showList([A|B]) :-                      
    format(' ~w ',A),                                                   % print individual element of the list aka (Head)
    (\+ (B = []) -> write(or) ; true),                                  % print 'or' only when it is not the last element or else continue true
    showList(B).                                                        % recursive the remaining elements of the list aka (Tail)

% Retrieved fact list base on facts and return the list.
factList(X,L) :-                                                        % find fact base on X, and get the list (L) of it.
    (
    X = 'order' -> order(L);
    X = 'perferences' -> perferences(L);
    X = 'meal' -> meal(L);
    X = 'payment' -> payment(L);
    X = 'promotion' -> meal(promotion,L);
    X = 'classic' -> meal(classic,L);
    X = 'sandwich' -> custom(sandwich,L);
    X = 'meat' -> custom(meat,L);
    X = 'salad' -> custom(salad,L);
    X = 'sauce' -> custom(sauce,L);
    X = 'side' -> side(L)
    ).

% check if user input exist in the fact of list.
checkList(Z,X) :-                                                       % check if order exist of user input.
    X = 'abort' -> abort;                                               % allow admin to terminate the system
    X = 'n';                                                            % if user input no
    X = 'y';                                                            % if user input yes
    X = 'none';(                                                        % if user choose none as option
    factList(Z,L),                                                      % call the list of fact Z and return the proper list
    member(Y,L), % print(X),                                            % for every member/element of the list in the order
    normalizeVar(Y,W,atom),
    (X = W,nl,!);                                                       % check if user option exist in the order, list double quotes are removed to check against user input.
    sorryMessage(X), false).                                            % show invalid message and return false if user input does not exist.

% Message show when invalid input is key in.
sorryMessage(X) :- format('Sorry \'~w\' is a invalid input, please re-key the correct option again.~n',[X]).

% Prompt user to choose a option
choose(X) :-  
    read_line_to_string(user_input,Y),                                  % prompt for user input
    normalizeVar(Y,X,string),                                           % normalize the string to appropriate term
    format('You have chosen ~w', [Y]), nl.                              % show that user has key in this letter

% normalize String and Convert to Term to be use for facts or comparison operation , the conversion is determine by X (string or atom)
normalizeVar(In,Out,X) :-
    (X = 'string' -> 
    (split_string(In," "," ",List),
    atomics_to_string(List, "", String));
    X = 'atom' -> 
    (atom_string(In, S1),
    string_lower(S1, S2),
    split_string(S2, " ", " ", L2), 
    atomics_to_string(L2, "", String))),
    term_string(Out, String). 

% Decision making logic that depend on user perferences of food
decision(X) :-
    (X = 'none');                                                      % no perferences will continue the queries.
    (((X = 'vegan' -> perferences(vegan,List));                        % vegan perference will remove option for meat
    (X = 'healthy' -> perferences(healthy,List))) ->                   % healthy perference will remove all sauce except italian and remove specific meat.
    updateFact(List)).

% Update changes base on the list of perferences.
updateFact(List):-
    custom(sandwich,ListSandwich),                                     % get the list of respective category of food
    custom(meat, ListMeat),
    custom(salad, ListSalad),
    custom(sauce, ListSauce),
    meal(promotion, ListPromotion),
    meal(classic,ListClassic),
    side(ListSide),

    intersection(ListSandwich, List, NewListSandwich),                 % exist in both lists of food will be allocated to the new list
    intersection(ListMeat, List, NewListMeat),
    intersection(ListSalad, List, NewListSalad),
    intersection(ListSauce, List, NewListSauce),
    intersection(ListPromotion, List, NewListPromotion),
    intersection(ListClassic, List, NewListClassic),
    intersection(ListSide, List, NewListSide),

    retractall(custom(_,_)),                                           % clear dynamic memory facts that related to changes
    retractall(meal(_,_)),
    retractall(side(_)),

    assertz(custom(sandwich,NewListSandwich)),                         % Update the new facts.
    assertz(custom(meat, NewListMeat)),
    assertz(custom(salad, NewListSalad)),
    assertz(custom(sauce, NewListSauce)),
    assertz(meal(promotion, NewListPromotion)),
    assertz(meal(classic, NewListClassic)),
    assertz(side(NewListSide)).

% Calculate the total price of food
totalPrice(X):-
    ((orderOption(meal) -> (
        (mealOption(promotion) -> 
            (promotionOption(A),
            findPrice(A,X1)));
        (mealOption(classic) -> 
            (classicOption(B),
            findPrice(B,X2)))));
    (orderOption(custom) -> (
        sandwichOption(C),
        meatOption(D),
        saladOption(E),
        sauceOption(F)   ,
        findPrice(C,X3),
        findPrice(D,X4),
        findPrice(E,X5),
        findPrice(F,X6)
      ))),
    topupOption(G),
    sideOption(H),
    findPrice(G,X7),
    findPrice(H,X8),
    ((not(orderOption(meal)) -> (X1 is 0, X2 is 0) -> (perferences(vegan) -> X4 is 0; perferences(meat) -> X3 is 0 ; true));
    ((orderOption(meal), mealOption(promotion)) -> X2 is 0, X3 is 0, X4 is 0, X5 is 0, X6 is 0); 
    ((orderOption(meal), mealOption(classic)) -> X1 is 0, X3 is 0, X4 is 0, X5 is 0, X6 is 0)),
    X is X1 + X2 + X3 + X4 + X5 + X6 + X7 + X8.

% Calculate the total price of the food by travrese through the list with corresponding price facts
findPrice(Y,X) :-
        (price(Z,W),
        normalizeVar(Z,Z1,atom),
        Z1 = Y -> X = W); X = 0. 

% Display Option that user have placed.
showChosenOption :-
    orderOption(A),
    ((orderOption(meal) -> 
        ((mealOption(promotion) -> (promotionOption(C),mealOption(B));
        (mealOption(classic) -> (classicOption(C),mealOption(B)))))); 
    (sandwichOption(C), meatOption(D),saladOption(E),sauceOption(F))),
    topupOption(G), 
    sideOption(H),
    ((A = 'meal' -> (format(' ~w ~w sandwich set and called ~w with additional ~w top up ~w side.~n',[B,A,C,G,H]))); 
    (format(' ~w sandwich set, ~w sandwich, ~w meat, ~w salad, ~w sauce. In addition, ~w top up and ~w side.~n',[A,C,E,D,F,G,H]))).
    
% ------------------------------------------------------------------------------------------------
% Queries 
% ------------------------------------------------------------------------------------------------
:- print("Loading Queries..."),nl.
% Prompt User For Decision (To Generate Facts For Rules to Apply Accordingly).
reload:-
    consult(['SSI_KBS']),                  % re-load and learn facts from database                      
    clearUserOption,                       % clear previous user selected option
    run.                                   

run:- 
    write('................................................................................'),nl,
    write('...SSSSSSS....UUUU...UUUU..BBBBBBBBBB.BBWWW..WWWWW...WWWA..AAAAA..AAAY....YYYY..'),nl,
    write('..SSSSSSSSS...UUUU...UUUU..BBBBBBBBBBB.BWWW..WWWWW..WWWW...AAAAA..AAAYY...YYYY..'),nl,
    write('..SSSSSSSSSS..UUUU...UUUU..BBBBBBBBBBB.BWWW..WWWWWW.WWWW..AAAAAA...AAYYY.YYYY...'),nl,
    write('.SSSSS..SSSS..UUUU...UUUU..BBBB...BBBB.BWWW.WWWWWWW.WWWW..AAAAAAA...AYYY.YYYY...'),nl,
    write('.SSSSS........UUUU...UUUU..BBBB...BBBB.BWWW.WWWWWWW.WWWW.AAAAAAAA...AYYYYYYY....'),nl,
    write('..SSSSSSS.....UUUU...UUUU..BBBBBBBBBBB..WWWWWWWWWWW.WWW..AAAAAAAA....YYYYYYY....'),nl,
    write('...SSSSSSSSS..UUUU...UUUU..BBBBBBBBBB...WWWWWWW.WWWWWWW..AAAA.AAAA....YYYYY.....'),nl,
    write('.....SSSSSSS..UUUU...UUUU..BBBBBBBBBBB..WWWWWWW.WWWWWWW.AAAAAAAAAA....YYYY......'),nl,
    write('........SSSSS.UUUU...UUUU..BBBB....BBBB.WWWWWWW.WWWWWWW.AAAAAAAAAAA...YYYY......'),nl,
    write('.SSSS....SSSS.UUUU...UUUU..BBBB....BBBB.WWWWWWW.WWWWWWW.AAAAAAAAAAA...YYYY......'),nl,
    write('.SSSSSSSSSSSS.UUUUUUUUUUU..BBBBBBBBBBBB..WWWWW...WWWWW.WAAA....AAAA...YYYY......'),nl,
    write('..SSSSSSSSSS...UUUUUUUUU...BBBBBBBBBBB...WWWWW...WWWWW.WAAA.....AAAA..YYYY......'),nl,
    write('...SSSSSSSS.....UUUUUUU....BBBBBBBBBB....WWWWW...WWWWWWWAAA.....AAAA..YYYY......'),nl,
    write('................................................................................'),nl,
    nl,nl,
    write('Welcome to Subway eatfresh do you want choose our'), 
    order(List),                            % get the options base on the facts
    showList(List),                         % display the options available
    write('sandwich?'), nl, 
    repeat,                                 % reprompt user for Option again if invalid input
    choose(Option),                         % call to prompt for user input
    checkList(order,Option),                % check if user input is valid
    assertz(orderOption(Option)),           % insert the new fact base on user option
    ask(1).

ask(1):- 
    write('Do you have any perferences such as'),
    perferences(List), 
    showList(List), 
    write('or none?'), nl,
    repeat,
    choose(Option),
    checkList(perferences,Option),
    assertz(perferencesOption(Option)),
    decision(Option),                       % to update facts base on user perferences
    (orderOption(meal) -> ask(meal);
    orderOption(custom) -> ask(sandwich)).

ask(meal):- 
    write('Do you want to try out our new'),
    meal(List),
    showList(List), 
    write('meal?'), nl, 
    repeat,
    choose(Option),
    checkList(meal,Option),
    assertz(mealOption(Option)), 
    (mealOption(promotion) -> ask(promotion); 
    mealOption(classic) -> ask(classic)).

ask(promotion):- 
    write('Which promotion meal would like to pick? We have'),
    meal(promotion,List),
    showList(List), 
    write('. All comes with a set of x1 Coke Drink and x3 New Flavour of Cookies.'), nl, 
    repeat,
    choose(Option),
    checkList(promotion,Option),
    assertz(promotionOption(Option)), 
    ask(topup).

ask(classic):-
    write('Which classic meal would you like to pick? We have'),
    meal(classic,List),
    showList(List), 
    write('. All comes with a set of x1 Coke Drink and x3 New Flavour of Cookies.'), nl, 
    repeat,
    choose(Option),
    checkList(classic,Option),
    assertz(classicOption(Option)), 
    ask(topup).

ask(topup):- 
    write('Do you want to top up to'),
    topup(List),
    showList(List),
    write('sandwich size? y/n'), nl, 
    repeat,
    choose(Option),
    checkList(topup,Option),
    (Option = 'y' -> assertz(topupOption(extreme));     % if user choose yes then add a fact base on user selected option
    Option = 'n' -> assertz(topupOption(normal))),      % if user choose no then add a fact base on user selected option
    ask(side). 

ask(side):-
    ((side([]));(                                       % if there exist a empty side list then go to next query
    write('Do you want to add any ala-carte such as'),
    side(List),
    showList(List),
    write('or none?'), nl, 
    repeat,
    choose(Option),
    checkList(side,Option),
    (Option = 'none' -> assertz(sideOption(none)); 
    assertz(sideOption(Option))))),
    ask(confirm). 

ask(confirm):-
    write('Your Order is'),
    showChosenOption,                                   % Show user orders in details
    write('Total Price would be $'), 
    totalPrice(X),                                      % Show the total price for the order
    write(X),write('.'),nl,
    write(' .Please confirm your order. y/n?'), nl,
    repeat,
    choose(Option),
    checkList(confirmation,Option),
    (Option = 'y' -> ask(payment);
    Option = 'n' -> reload).                            % re-start the query again

ask(payment):-
    write('Would you like to pay in'),
    payment(List),
    showList(List),
    write('?'), nl,
    repeat,
    choose(Option),
    checkList(payment,Option),
    assertz(paymentOption(Option)),
    ask(end).

ask(end):-
    write('Your sandwich is preparing, please wait for 3 minutes! Hope you enjoy our service and have a nice day! '),
    write(''),nl,
    sleep(3),                                          % delay for 3 second to show the duration of the encryption process of the payment 
    reload.

ask(sandwich):-
    write('Which sandwich bread options would you like to pick? We have'),
    custom(sandwich,List),
    showList(List), 
    write('.'), nl, 
    repeat,
    choose(Option),
    checkList(sandwich,Option),
    assertz(sandwichOption(Option)),
    ask(meat).

ask(meat):-
    ((custom(meat,[]) -> assertz(meatOption(none)));(        % if there exist a empty meat list (like vegan perferences) then go to next query
    write('Which meat options would you like to pick? We have'),
    custom(meat,List),
    showList(List), 
    write('or none.'), nl, 
    repeat,
    choose(Option),
    checkList(meat,Option),
    assertz(meatOption(Option)),
    (Option = 'none' -> assertz(meatOption(none));      
    assertz(meatOption(Option))))),
    ask(salad).

ask(salad):-
    ((custom(salad,[]) -> assertz(saladOption(none)));(      % if there exist a empty salad list then go to next query
    write('Which salad options would you like to pick? We have'),
    custom(salad,List),
    showList(List), 
    write('or none.'), nl, 
    repeat,
    choose(Option),
    checkList(salad,Option),
    assertz(saladOption(Option)),
    (Option = 'none' -> assertz(saladOption(none)); 
    assertz(saladOption(Option))))),
    ask(sauce).

ask(sauce):-
    ((custom(sauce,[]) -> assertz(sauceOption(none)));(      % if there exist a empty sauce list then go to next query
    write('Which type of sauce would you like to have? We have'),
    custom(sauce,List),
    showList(List), 
    write('or none.'), nl, 
    repeat,
    choose(Option),
    checkList(sauce,Option),
    assertz(sauceOption(Option)),
    (Option = 'none' -> assertz(sauceOption(none)); 
    assertz(sauceOption(Option))))),
    ask(topup).

:- print("End"),nl.

% ------------------------------------------------------------------------------------------------
% ------------------------------------------------------------------------------------------------


