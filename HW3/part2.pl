% Facts

flight(canakkale,erzincan,6).
flight(erzincan,canakkale,6).
flight(erzincan,antalya,3).
flight(antalya,erzincan,3).
flight(antalya,diyarbakir,4).
flight(diyarbakir,antalya,4).
flight(antalya,izmir,2).
flight(izmir,antalya,2).
flight(izmir,istanbul,2).
flight(istanbul,izmir,2).
flight(izmir,ankara,6).
flight(ankara,izmir,6).
flight(ankara,istanbul,1).
flight(istanbul,ankara,1).
flight(diyarbakir,ankara,8).
flight(ankara,diyarbakir,8).
flight(istanbul,rize,4).
flight(rize,istanbul,4).
flight(rize,ankara,5).
flight(ankara,rize,5).
flight(ankara,van,4).
flight(van,ankara,4).
flight(van,gaziantep,3).
flight(gaziantep,van,3).

% Rules

route(CITY,CITY2,X) :- flight(CITY,CITY2,X). % If there is a flight between two cities then return true
route(CITY,CITY2,X) :- connected(CITY,CITY2,X,[]) , not(flight(CITY,CITY2,X)). % Otherwise, we need to traverse all the vertices to find the cost between cities. We have to use list to hold the visited vertices.
% To prevent the printing of the first vertice and city twice, we took the not of flight method. If there is a flight then first route will handle it. 
connected(START,DEST,X,_) :- flight(START,DEST,X). % Base Case for connected
connected(START,DEST,X,LIST) :- not(member(START,LIST)), flight(START,CITY,Y), connected(CITY,DEST,Z,[START|LIST]), START \= DEST, X is Y + Z.
% Recursive Case for connected. 
% If the START is not in the list then we can take a look for a flight between the START and other cities. If there is a flight then the cost of this flight is Y.
% After this, we will call connected recursively until we reach DEST. It is called with CITY so it will be kind of a bridge between START and DEST.
% Z is the cost of the whole recursive operation. We are adding START into the LIST so we will not consider it again. In this recursive call, START should not be equal
% to the DEST, If it is equal then there will be a infinite loop. X will be the addition of Y (START -> CITY) and Z (CITY -> DEST (recursively)) 