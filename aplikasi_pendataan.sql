-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 16, 2019 at 08:11 PM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.3.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aplikasi_pendataan`
--

-- --------------------------------------------------------

--
-- Table structure for table `jurusan`
--

CREATE TABLE `jurusan` (
  `kd_jurusan` varchar(10) NOT NULL,
  `jurusan` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jurusan`
--

INSERT INTO `jurusan` (`kd_jurusan`, `jurusan`) VALUES
('mm', 'Multimedia'),
('rpl', 'Rekayasa Perangkat Lunak'),
('tkj', 'Teknik Komputer Jaringan');

-- --------------------------------------------------------

--
-- Table structure for table `lab`
--

CREATE TABLE `lab` (
  `kd_lab` varchar(10) NOT NULL,
  `lab` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lab`
--

INSERT INTO `lab` (`kd_lab`, `lab`) VALUES
('rpl', 'RPL'),
('tkj', 'TKJ');

-- --------------------------------------------------------

--
-- Table structure for table `nilai`
--

CREATE TABLE `nilai` (
  `kd_nilai` varchar(10) NOT NULL,
  `nisn` varchar(15) NOT NULL,
  `kd_jurusan` varchar(10) NOT NULL,
  `kd_lab` varchar(10) NOT NULL,
  `total_nilai` int(5) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `nilai`
--

INSERT INTO `nilai` (`kd_nilai`, `nisn`, `kd_jurusan`, `kd_lab`, `total_nilai`) VALUES
('0021190904', '0021190904', 'rpl', 'rpl', 1150),
('0021190906', '0021190906', 'rpl', 'rpl', 300);

-- --------------------------------------------------------

--
-- Table structure for table `siswa`
--

CREATE TABLE `siswa` (
  `nis` varchar(15) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `sekolah` varchar(50) NOT NULL,
  `jk` varchar(10) NOT NULL,
  `jurusan` varchar(10) NOT NULL,
  `lab` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `siswa`
--

INSERT INTO `siswa` (`nis`, `nama`, `sekolah`, `jk`, `jurusan`, `lab`) VALUES
('0021190904', 'Rizal Pahlevi', 'SMKN 4', 'Laki-laki', 'rpl', 'rpl'),
('0021190906', 'Prio Arief Gunawan', 'SMKN 4 Kota Tangerang', 'Laki-laki', 'rpl', 'rpl');

-- --------------------------------------------------------

--
-- Stand-in structure for view `tampil_nilai`
-- (See below for the actual view)
--
CREATE TABLE `tampil_nilai` (
`nis` varchar(15)
,`nama` varchar(50)
,`sekolah` varchar(50)
,`jurusan` varchar(40)
,`lab` varchar(10)
,`total_nilai` int(5)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `tampil_siswa`
-- (See below for the actual view)
--
CREATE TABLE `tampil_siswa` (
`nis` varchar(15)
,`nama` varchar(50)
,`sekolah` varchar(50)
,`jk` varchar(10)
,`jurusan` varchar(40)
,`lab` varchar(10)
);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`username`, `password`) VALUES
('admin', 'admin');

-- --------------------------------------------------------

--
-- Structure for view `tampil_nilai`
--
DROP TABLE IF EXISTS `tampil_nilai`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tampil_nilai`  AS  select `s`.`nis` AS `nis`,`s`.`nama` AS `nama`,`s`.`sekolah` AS `sekolah`,`j`.`jurusan` AS `jurusan`,`l`.`lab` AS `lab`,`n`.`total_nilai` AS `total_nilai` from (((`siswa` `s` join `jurusan` `j`) join `lab` `l`) join `nilai` `n`) where ((`j`.`kd_jurusan` = `s`.`jurusan`) and (`l`.`lab` = `s`.`lab`) and (`j`.`kd_jurusan` = `n`.`kd_jurusan`) and (`l`.`kd_lab` = `n`.`kd_lab`) and (`s`.`nis` = `n`.`nisn`)) ;

-- --------------------------------------------------------

--
-- Structure for view `tampil_siswa`
--
DROP TABLE IF EXISTS `tampil_siswa`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tampil_siswa`  AS  select `s`.`nis` AS `nis`,`s`.`nama` AS `nama`,`s`.`sekolah` AS `sekolah`,`s`.`jk` AS `jk`,`j`.`jurusan` AS `jurusan`,`l`.`lab` AS `lab` from ((`siswa` `s` join `jurusan` `j`) join `lab` `l`) where ((`j`.`kd_jurusan` = `s`.`jurusan`) and (`l`.`kd_lab` = `s`.`lab`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `jurusan`
--
ALTER TABLE `jurusan`
  ADD PRIMARY KEY (`kd_jurusan`);

--
-- Indexes for table `lab`
--
ALTER TABLE `lab`
  ADD PRIMARY KEY (`kd_lab`);

--
-- Indexes for table `nilai`
--
ALTER TABLE `nilai`
  ADD PRIMARY KEY (`kd_nilai`),
  ADD UNIQUE KEY `nisn_2` (`nisn`),
  ADD KEY `nisn` (`nisn`),
  ADD KEY `kd_jurusan` (`kd_jurusan`),
  ADD KEY `kd_lab` (`kd_lab`);

--
-- Indexes for table `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`nis`),
  ADD KEY `lab` (`lab`),
  ADD KEY `jurusan` (`jurusan`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`username`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `nilai`
--
ALTER TABLE `nilai`
  ADD CONSTRAINT `nilai_ibfk_1` FOREIGN KEY (`nisn`) REFERENCES `siswa` (`nis`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nilai_ibfk_2` FOREIGN KEY (`kd_jurusan`) REFERENCES `jurusan` (`kd_jurusan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nilai_ibfk_3` FOREIGN KEY (`kd_lab`) REFERENCES `lab` (`kd_lab`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `siswa`
--
ALTER TABLE `siswa`
  ADD CONSTRAINT `siswa_ibfk_2` FOREIGN KEY (`lab`) REFERENCES `lab` (`kd_lab`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `siswa_ibfk_3` FOREIGN KEY (`jurusan`) REFERENCES `jurusan` (`kd_jurusan`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
