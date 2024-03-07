-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-03-2024 a las 16:31:40
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `m7_prac_uf3`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pilots`
--

CREATE TABLE `pilots` (
  `name` varchar(64) NOT NULL,
  `team` varchar(64) NOT NULL,
  `points` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pilots`
--

INSERT INTO `pilots` (`name`, `team`, `points`) VALUES
('Carlos Sainz', 'Ferrari', 59),
('Charles Leclerc', 'Ferrari', 53),
('Chucho Perez', 'RedBull', 12),
('Fernando Alonso', 'Aston Martin', 78),
('George Rusell', 'Mercedes', 49),
('Kevin Magnussen', 'Haas', 12),
('Lance Stroll', 'Aston Martin', 33),
('Lando Norris', 'McLaren', 42),
('Lloros Hamilton', 'Mercedes', 39),
('Max Verstappen', 'RedBull', 145),
('Nico Hülkenberg', 'Haas', 7),
('Oscar Piastri', 'McLaren', 28);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `pilot_points`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `pilot_points` (
`Pilot` varchar(64)
,`Team` varchar(64)
,`points` int(3)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `teams`
--

CREATE TABLE `teams` (
  `name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `teams`
--

INSERT INTO `teams` (`name`) VALUES
('Aston Martin'),
('Ferrari'),
('Haas'),
('McLaren'),
('Mercedes'),
('RedBull');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `team_points`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `team_points` (
`Team` varchar(64)
,`Points` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `pilot_points`
--
DROP TABLE IF EXISTS `pilot_points`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pilot_points`  AS SELECT `p`.`name` AS `Pilot`, `p`.`team` AS `Team`, `p`.`points` AS `points` FROM `pilots` AS `p` ORDER BY `p`.`points` DESC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `team_points`
--
DROP TABLE IF EXISTS `team_points`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `team_points`  AS SELECT `t`.`name` AS `Team`, sum(`p`.`points`) AS `Points` FROM (`teams` `t` join `pilots` `p` on(`t`.`name` = `p`.`team`)) GROUP BY `t`.`name` ORDER BY sum(`p`.`points`) DESC ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `pilots`
--
ALTER TABLE `pilots`
  ADD PRIMARY KEY (`name`),
  ADD KEY `team` (`team`);

--
-- Indices de la tabla `teams`
--
ALTER TABLE `teams`
  ADD PRIMARY KEY (`name`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `pilots`
--
ALTER TABLE `pilots`
  ADD CONSTRAINT `pilots_ibfk_1` FOREIGN KEY (`team`) REFERENCES `teams` (`name`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
