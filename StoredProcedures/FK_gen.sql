
--Facturas
ALTER TABLE Facturas
ADD FOREIGN KEY (cod_publi)
REFERENCES Publicaciones(cod_publi)

--Publicaciones
ALTER TABLE Publicaciones
ADD FOREIGN KEY (cod_visibilidad)
REFERENCES Visibilidades(cod_visibilidad)

ALTER TABLE Publicaciones
ADD FOREIGN KEY (cod_estado)
REFERENCES EstadosPublicacion(cod_estado)

ALTER TABLE Publicaciones
ADD FOREIGN KEY (cod_rubro)
REFERENCES Rubros(cod_rubro)

ALTER TABLE Publicaciones
ADD FOREIGN KEY (cod_usuario)
REFERENCES Usuarios(cod_usuario)

-- Historica
ALTER TABLE Historica
ADD FOREIGN KEY (cod_publi)
REFERENCES Publicaciones(cod_publi)

ALTER TABLE Historica
ADD FOREIGN KEY (cod_comprador)
REFERENCES Usuarios(cod_usuario)

--Administradores
ALTER TABLE Administradores
ADD FOREIGN KEY (cod_usuario)
REFERENCES Usuarios(cod_usuario)

--Clientes
ALTER TABLE Clientes
ADD FOREIGN KEY (cod_usuario)
REFERENCES Usuarios(cod_usuario)

--Empresas
ALTER TABLE Empresas
ADD FOREIGN KEY (cod_usuario)
REFERENCES Usuarios(cod_usuario)

--Usuarios
ALTER TABLE Usuarios
ADD FOREIGN KEY (cod_rol)
REFERENCES Roles(cod_rol)


--Roles Usuarios
ALTER TABLE Roles_Usuario
ADD FOREIGN KEY (cod_usuario)
REFERENCES Usuarios(cod_usuario)

ALTER TABLE Roles_Usuario
ADD FOREIGN KEY (cod_rol)
REFERENCES Roles(cod_rol)

--Perfiles
ALTER TABLE Perfiles
ADD FOREIGN KEY (cod_funcionalidad)
REFERENCES Funcionalidades(cod_funcionalidad)

ALTER TABLE Perfiles
ADD FOREIGN KEY (cod_rol)
REFERENCES Roles(cod_rol)

--Items Por Factura
ALTER TABLE Items_por_facturas
ADD FOREIGN KEY (num_factura)
REFERENCES Facturas(num_factura)

ALTER TABLE Items_por_facturas
ADD FOREIGN KEY (cod_item)
REFERENCES Items(cod_item)




