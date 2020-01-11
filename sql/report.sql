/* Select all students from class 2a by knowing id = 2 */
SELECT * FROM cr06_steven_markhardt_school.student WHERE fk_classID = 2
/* Select all students from class 2a while not knowing the id */
SELECT studentID, studentFirstName, studentSurname, studentmail, fk_classID FROM cr06_steven_markhardt_school.student INNER JOIN cr06_steven_markhardt_school.class ON student.fk_classID = class.classID && class.className = "2a"

