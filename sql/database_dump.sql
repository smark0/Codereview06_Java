-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 12. Jan 2020 um 00:23
-- Server-Version: 10.4.10-MariaDB
-- PHP-Version: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `cr06_steven_markhardt_school`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `class`
--

CREATE TABLE `class` (
  `classID` int(11) NOT NULL,
  `className` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `class`
--

INSERT INTO `class` (`classID`, `className`) VALUES
(1, '1a'),
(2, '1b'),
(3, '2a'),
(4, '2b'),
(5, '3a'),
(6, '3b'),
(7, '4a'),
(8, '4b');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `student`
--

CREATE TABLE `student` (
  `studentID` int(11) NOT NULL,
  `studentFirstName` varchar(55) DEFAULT NULL,
  `studentSurname` varchar(55) DEFAULT NULL,
  `studentMail` varchar(55) DEFAULT NULL,
  `fk_classID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `student`
--

INSERT INTO `student` (`studentID`, `studentFirstName`, `studentSurname`, `studentMail`, `fk_classID`) VALUES
(1, 'John', 'Doe', 'john.doe@domain.com', 1),
(2, 'Jane', 'Doe', 'jane.doe@domain.com', 2),
(3, 'James', 'Bond', 'james.bond@007.com', 3),
(4, 'Chris', 'Evans', 'chris.evans@avengers.com', 4),
(5, 'John', 'Cena', 'john.cena@wwe.com', 5),
(6, 'Richard', 'Lugner', 'richirich@lugnercity.at', 6),
(7, 'Geronimo', 'Röder', 'g.röder@rocketbeans.de', 7),
(8, 'Arthur', 'Pendragon', 'king.arthur@avalon.com', 8);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `teacher`
--

CREATE TABLE `teacher` (
  `teacherID` int(11) NOT NULL,
  `teacherName` varchar(55) DEFAULT NULL,
  `teacherSurname` varchar(55) DEFAULT NULL,
  `teacherMail` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `teacher`
--

INSERT INTO `teacher` (`teacherID`, `teacherName`, `teacherSurname`, `teacherMail`) VALUES
(1, 'Harry', 'Potter', 'hp@hogwarts.com'),
(2, 'Harry', 'Houdini', 'h.houdini@magic.com'),
(3, 'George', 'Clooney', 'g.clooney@nespresso.com'),
(4, 'Peter', 'Pan', 'p.pan@disney.com'),
(5, 'Herbert', 'Prohaska', 'h.prohaska@orf.at'),
(6, 'Michael', 'Jackson', 'mj@neverland.com'),
(7, 'Stephen', 'Hawking', 'smarterthanu@bigbrain.com'),
(8, 'Walter', 'White', 'drugsarebad@breakingbad.com');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `teacher2class`
--

CREATE TABLE `teacher2class` (
  `fk_teacherID` int(11) DEFAULT NULL,
  `fk_classID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `teacher2class`
--

INSERT INTO `teacher2class` (`fk_teacherID`, `fk_classID`) VALUES
(1, 2),
(1, 6),
(2, 2),
(2, 8),
(3, 5),
(3, 8),
(4, 6),
(4, 8),
(5, 1),
(5, 3),
(6, 3),
(6, 7),
(7, 1),
(7, 7),
(8, 1),
(8, 5);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `class`
--
ALTER TABLE `class`
  ADD PRIMARY KEY (`classID`);

--
-- Indizes für die Tabelle `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`studentID`),
  ADD KEY `fk_classID` (`fk_classID`) USING BTREE;

--
-- Indizes für die Tabelle `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`teacherID`);

--
-- Indizes für die Tabelle `teacher2class`
--
ALTER TABLE `teacher2class`
  ADD KEY `fk_teacherID` (`fk_teacherID`,`fk_classID`) USING BTREE,
  ADD KEY `fk_classID` (`fk_classID`) USING BTREE;

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `class`
--
ALTER TABLE `class`
  MODIFY `classID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT für Tabelle `student`
--
ALTER TABLE `student`
  MODIFY `studentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT für Tabelle `teacher`
--
ALTER TABLE `teacher`
  MODIFY `teacherID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `student_ibfk_1` FOREIGN KEY (`fk_classID`) REFERENCES `class` (`classID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `teacher2class`
--
ALTER TABLE `teacher2class`
  ADD CONSTRAINT `teacher2class_ibfk_1` FOREIGN KEY (`fk_classID`) REFERENCES `class` (`classID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `teacher2class_ibfk_2` FOREIGN KEY (`fk_teacherID`) REFERENCES `teacher` (`teacherID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
