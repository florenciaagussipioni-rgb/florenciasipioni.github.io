-- ========================================
-- TRABAJO PRACTICO: BASE DE DATOS AUDITORES
-- ========================================
-- Sistema de gestión de auditorías para cadenas retail
-- Fecha: 2026-06-25
-- Autor: Florencia Sipioni
-- Motor: MariaDB 10.4.32
-- ========================================

-- Crear base de datos
DROP DATABASE IF EXISTS `auditores`;
CREATE DATABASE `auditores` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `auditores`;

-- ========================================
-- TABLA: AUDITOR
-- ========================================
-- Almacena información de los auditores que realizan las visitas
CREATE TABLE `auditor` (
  `id_auditor` INT(3) NOT NULL AUTO_INCREMENT,
  `nombre_auditor` VARCHAR(25) NOT NULL,
  `apellido_auditor` VARCHAR(25) NOT NULL,
  `contacto_auditor` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_auditor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insertar datos de auditores
INSERT INTO `auditor` (`nombre_auditor`, `apellido_auditor`, `contacto_auditor`) VALUES
('Gustavo', 'Gerez', '1123232487'),
('Julieta', 'Sanchez', '1134576892'),
('Javier', 'Perez', '1175830223'),
('Victoria', 'Bustamante', '1130484523'),
('Carlos', 'Vallejos', '1134500456'),
('Cristian', 'Grafos', '45862105');

-- ========================================
-- TABLA: CLIENTES
-- ========================================
-- Almacena información de las empresas que contratan auditorías
CREATE TABLE `clientes` (
  `id_cliente` INT(4) NOT NULL AUTO_INCREMENT,
  `nombre_cliente` VARCHAR(25) NOT NULL,
  `contacto_cliente` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insertar datos de clientes
INSERT INTO `clientes` (`nombre_cliente`, `contacto_cliente`) VALUES
('Unilever Argentina', '48586971'),
('Molinos Ríos de la Plata', '48588792'),
('Arcor', '58142597'),
('Danone Argentina', '485878517'),
('Nestlé Argentina', '58956971'),
('SC Johnson', '15547811'),
('Kimberly Clark', '156489932'),
('Coca-Cola FEMSA', '1532998712');

-- ========================================
-- TABLA: EMPRESA
-- ========================================
-- Almacena información de las cadenas retail donde se realizan auditorías
CREATE TABLE `empresa` (
  `idEmpresa` INT(3) NOT NULL AUTO_INCREMENT,
  `nombre_empresa` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`idEmpresa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insertar datos de empresas retail
INSERT INTO `empresa` (`nombre_empresa`) VALUES
('Carrefour'),
('Chango Más'),
('Disco'),
('Jumbo'),
('Coto');

-- ========================================
-- TABLA: PUNTO_DE_VENTA
-- ========================================
-- Almacena información de los locales/sucursales de las cadenas retail
CREATE TABLE `punto_de_venta` (
  `idPunto_venta` INT(3) NOT NULL AUTO_INCREMENT,
  `nombre_punto_venta` VARCHAR(25) NOT NULL,
  `direccion_punto_venta` VARCHAR(50) NOT NULL,
  `idEmpresa` INT(3) NOT NULL,
  PRIMARY KEY (`idPunto_venta`),
  KEY `FKempresa` (`idEmpresa`),
  CONSTRAINT `punto_de_venta_ibfk_1` FOREIGN KEY (`idEmpresa`) 
    REFERENCES `empresa` (`idEmpresa`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insertar datos de puntos de venta
INSERT INTO `punto_de_venta` (`nombre_punto_venta`, `direccion_punto_venta`, `idEmpresa`) VALUES
('Carrefour Caballito', 'Av. Rivadavia 5600 CABA', 1),
('Coto Almagro', 'Av. Díaz Vélez 4600 CABA', 5),
('Jumbo Palermo', 'Av. Bullrich 345 CABA', 4),
('Disco Belgrano', 'Av. Cabildo 2300 CABA', 3),
('Chango Más', 'Av. Beiró 5200 CABA', 2),
('Carrefour San Isidro', 'Av. Centenario 1200 San Isidro', 1),
('Coto Quilmes', 'Av. Calchaquí 3950 Quilmes', 5),
('Jumbo Pilar', 'Panamericana Km 50 Pilar', 4);

-- ========================================
-- TABLA: VISITA
-- ========================================
-- Almacena información de las visitas de auditoría realizadas
-- Una visita puede incluir múltiples relevamientos
CREATE TABLE `visita` (
  `id_visita` INT(4) NOT NULL AUTO_INCREMENT,
  `id_auditor` INT(3) NOT NULL,
  `idPunto_venta` INT(3) NOT NULL,
  `fecha_visita` DATE NOT NULL,
  `hs_inicio_visita` TIME NOT NULL,
  `hs_fin_visita` TIME NOT NULL,
  `cant_servicios` INT(1) NOT NULL,
  `estado_visita` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`id_visita`),
  KEY `FKAuditor` (`id_auditor`),
  KEY `FKPunto_venta` (`idPunto_venta`),
  CONSTRAINT `visita_ibfk_1` FOREIGN KEY (`idPunto_venta`) 
    REFERENCES `punto_de_venta` (`idPunto_venta`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `visita_ibfk_2` FOREIGN KEY (`id_auditor`) 
    REFERENCES `auditor` (`id_auditor`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insertar datos de visitas
INSERT INTO `visita` (`id_auditor`, `idPunto_venta`, `fecha_visita`, `hs_inicio_visita`, `hs_fin_visita`, `cant_servicios`, `estado_visita`) VALUES
(1, 1, '2026-05-12', '09:00:00', '10:30:00', 1, 'Finalizado'),
(4, 2, '2026-05-13', '08:00:00', '09:00:00', 1, 'Finalizado'),
(5, 3, '2026-05-14', '08:30:00', '12:00:00', 2, 'Finalizado'),
(6, 5, '2026-05-14', '11:00:00', '12:30:00', 3, 'Finalizado'),
(7, 6, '2026-06-16', '12:00:00', '13:00:00', 1, 'Finalizado'),
(7, 7, '2026-06-11', '07:00:00', '09:00:00', 1, 'Finalizado'),
(9, 8, '2026-06-03', '11:00:00', '13:00:00', 2, 'Pendiente'),
(1, 3, '2026-06-20', '10:00:00', '11:00:00', 1, 'Pendiente'),
(6, 6, '2026-06-01', '09:00:00', '10:30:00', 1, 'Pendiente'),
(1, 2, '2026-05-14', '08:30:00', '11:00:00', 3, 'Finalizado'),
(1, 7, '2026-06-18', '08:00:00', '09:30:00', 1, 'Programada');

-- ========================================
-- TABLA: RELEVAMIENTO
-- ========================================
-- Almacena información de los relevamientos específicos realizados en cada visita
-- Un relevamiento es un servicio/tarea de auditoría para un cliente específico
CREATE TABLE `relevamiento` (
  `id_relevamiento` INT(10) NOT NULL AUTO_INCREMENT,
  `id_cliente` INT(4) NOT NULL,
  `id_visita` INT(4) NOT NULL,
  `descripcion_relevamiento` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id_relevamiento`),
  KEY `FKid_cliente` (`id_cliente`),
  KEY `id_visita` (`id_visita`),
  CONSTRAINT `relevamiento_ibfk_1` FOREIGN KEY (`id_cliente`) 
    REFERENCES `clientes` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relevamiento_ibfk_2` FOREIGN KEY (`id_visita`) 
    REFERENCES `visita` (`id_visita`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insertar datos de relevamientos
INSERT INTO `relevamiento` (`id_cliente`, `id_visita`, `descripcion_relevamiento`) VALUES
(1, 1, 'Exhibición correcta de línea Rexona. Se detectó faltante de 2 productos.'),
(3, 2, 'Verificación de precios de chocolates. Promoción vigente correctamente aplicada.'),
(2, 3, 'Control de góndola de fideos y harinas. Participación de espacio adecuada.'),
(4, 4, 'Revisión de yogures y postres. Stock completo.'),
(5, 4, 'Verificación de cafés y cereales. Competencia con promoción especial.'),
(4, 4, 'Relevamiento pendiente de precios.'),
(6, 4, 'Relevamiento de insecticidas y limpiadores. Material POP visible.'),
(7, 5, 'Control de pañales y papel higiénico. Sin observaciones.'),
(8, 6, 'Auditoría de bebidas. Correcta exhibición en cabecera.'),
(3, 7, 'Auditoría pendiente de góndolas y stock.'),
(3, 7, 'Control de precios realizado. Se detectó diferencia de $50 respecto al precio sugerido.'),
(2, 8, 'Pendiente relevamiento de harinas. Stock completo y señalización visible.'),
(4, 9, 'Yogures correctamente exhibidos en sector refrigerado.'),
(5, 9, 'Café instantáneo con presencia en cabecera promocional.'),
(7, 9, 'Verificación de pañales. Competencia ocupando mayor espacio de góndola.');

-- ========================================
-- CONSULTAS IMPORTANTES
-- ========================================

-- Q1: Auditores con cantidad de visitas realizadas
-- SELECT 
--     a.id_auditor,
--     CONCAT(a.nombre_auditor, ' ', a.apellido_auditor) AS nombre_completo,
--     COUNT(v.id_visita) AS total_visitas,
--     SUM(v.cant_servicios) AS total_servicios
-- FROM auditor a
-- LEFT JOIN visita v ON a.id_auditor = v.id_auditor
-- GROUP BY a.id_auditor
-- ORDER BY total_visitas DESC;

-- Q2: Distribución de visitas por estado
-- SELECT 
--     estado_visita,
--     COUNT(*) AS cantidad,
--     ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM visita), 2) AS porcentaje
-- FROM visita
-- GROUP BY estado_visita;

-- Q3: Clientes más auditados
-- SELECT 
--     c.nombre_cliente,
--     COUNT(r.id_relevamiento) AS total_relevamientos
-- FROM clientes c
-- LEFT JOIN relevamiento r ON c.id_cliente = r.id_cliente
-- GROUP BY c.id_cliente
-- ORDER BY total_relevamientos DESC;

-- ========================================
-- FIN DE LA BASE DE DATOS
-- ========================================
