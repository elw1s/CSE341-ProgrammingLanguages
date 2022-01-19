:- dynamic room/4.
:- dynamic course/7.
:- dynamic student/3.


% Rooms

room(z10,30,[8,9,10,11,12,13,14,15,16,17],[projector,smartBoard]).
room(z23,50,[8,9,10,11,12,13,14,15,16,17],[projector,smartBoard,handicapped]).
room(z06,35,[8,9,10,11,12,13,14,15,16,17],[smartBoard]).
room(z04,20,[8,9,10,11,12,13,14,15,16,17],[projector,handicapped]).

% Occupancy

occupancy(z10,[9,10,11],cse341).
occupancy(z23,[9,10],cse321).
occupancy(z06,[13,14],cse331).
occupancy(z10,[12,13],cse241).
occupancy(z23,[15,16],cse222).
occupancy(z04,[9,10],cse311).


% Courses

course(cse341,ahmet,25,[9,10,11],z10,[5,6,7],[projector,smartBoard]).
course(cse321,mehmet,45,[9,10],z23,[5,6,7,8,9],[smartBoard,handicapped]).
course(cse331,john,30,[13,14],z06,[1,3],[smartBoard]).
course(cse241,michael,25,[12,13],z10,[1,2,3,4,5],[projector]).
course(cse222,selena,28,[15,16],z23,[4,7,8],[smartBoard,handicapped]).
course(cse311,ashley,10,[9,10],z04,[3,6,8],[projector]).

% Instructor

instructor(ahmet,[cse341],[projector]).
instructor(mehmet,[cse321],[handicapped]).
instructor(john,[cse331],[smartBoard]).
instructor(michael,[cse241],[projector]).
instructor(selena,[cse222],[handicapped]).
instructor(ashley,[cse311],_).

% Students

student(1,[cse331,cse241],_).
student(2,[cse241],_).
student(3,[cse331,cse241],_).
student(4,[cse241,cse222],handicapped).
student(5,[cse341,cse321,cse241],_).
student(6,[cse341,cse321,cse311],_).
student(7,[cse341,cse321,cse222],_).
student(8,[cse321,cse222,cse311],handicapped).
student(9,[cse321],_).

% Queries


/* EXAMPLE QUERY => conflict(cse331,cse241), True if there is conflict, False when there is not. (Check whether there is any scheduling conflict) */
conflict(C1,C2) :- course(C1,_,_,HOURS1,ROOM1,_,_),
                   course(C2,_,_,HOURS2,ROOM2,_,_),
                   C1 \= C2,
                   ROOM1 == ROOM2, 
                   find(HOURS1,HOURS2).
/* Finds the member of a list into another list */
find([Head|Tail], LIST) :- (memberchk(Head, LIST) ->
                            true;
                            find(Tail,LIST)).

/* EXAMPLE QUERY => assign(cse341, ROOM), ROOM variable will be appropriate rooms (Check which room can be assigned to a given class) */
/* EXAMPLE QUERY => assign(CLASS,ROOM), CLASS and ROOM variables will be appropriate values. (Check which room can be assigned to which classes) */
assign(CLASS,ROOM):- room(ROOM,CAP,_,EQUIPMENT),
                     course(CLASS,INS,SIZE,_,_,_,NEEDS),
                     CAP >= SIZE,
                     find(NEEDS,EQUIPMENT),
                     instructor(INS,_,PREFERENCES),
                     find(PREFERENCES,EQUIPMENT).
/* EXAMPLE QUERY => enroll(cse341,5), True if the given student can enroll to the given class. (Check whether a student can be enrolled to a given class) */
enroll(CLASS,STUDENT):- course(CLASS,_,CAP,_,ROOM,STUDENTS,_),
                        room(ROOM,_,_,EQUIPMENT),
                        length(STUDENTS, NUM),
                        (NUM+1) =< CAP,
                        student(STUDENT,_,HANDICAP),
                        (var(HANDICAP) ->
                            true;
                            memberchk(HANDICAP, EQUIPMENT)
                        ).
/* EXAMPLE QUERY => assignStudent(X,Y), X will be the ID of course, Y will be the ID of the student (Check which classes a student can be assigned)*/
assignStudent(CLASS,STUDENT):- student(STUDENT,_,HANDICAP),
                               course(CLASS,_,CAP,_,ROOM,STUDENTS,_),
                               length(STUDENTS, NUM),
                               (NUM+1) =< CAP,
                               room(ROOM,R_CAP,_,EQUIPMENT),
                               R_CAP >= (NUM+1),
                               (var(HANDICAP) ->
                                    true;
                                    memberchk(HANDICAP, EQUIPMENT)
                               ).
/* Add to the system */
addStudent(ID,COURSES,HANDICAP) :- assertz(student(ID,COURSES,HANDICAP)).
addCourse(ID,NAME,CAP,HOURS,ROOM,STUDENTS,NEEDS) :- assertz(course(ID,NAME,CAP,HOURS,ROOM,STUDENTS,NEEDS)).
addRoom(ID,CAP,HOURS,EQUIPMENTS) :- assertz(room(ID,CAP,HOURS,EQUIPMENTS)).

                               
                        






