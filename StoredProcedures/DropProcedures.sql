USE GD1C2016
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Germán Rodriguez
-- Create date: 12/06/2016
-- Description:	
-- =============================================
create PROCEDURE DropProcedures AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	exec DE_UNA.DropTables;
	DROP PROCEDURE [DE_UNA].CrearTablas;
	DROP PROCEDURE [DE_UNA].DropTables;
	DROP PROCEDURE [DE_UNA].Migrar_Ofertas;
	DROP PROCEDURE [DE_UNA].MigrarCompras;
	DROP PROCEDURE [DE_UNA].MigrarFacturas;
	DROP PROCEDURE [DE_UNA].MigrarPublicaciones;
	DROP PROCEDURE [DE_UNA].MigrarUsuarioCliente;
	DROP PROCEDURE [DE_UNA].MigrarUsuarioEmpresa;
	DROP PROCEDURE [DE_UNA].PoblarTablasSinDependencias;

	DROP PROCEDURE [DE_UNA].ActualizarPublicacion;
	DROP PROCEDURE [DE_UNA].ActualizarRol;
	DROP PROCEDURE [DE_UNA].ActualizarVisibilidad;
	DROP PROCEDURE [DE_UNA].BuscarXdetalle;
	DROP PROCEDURE [DE_UNA].Calificar_Compra;
	DROP PROCEDURE [DE_UNA].CrearCompra;
	DROP PROCEDURE [DE_UNA].CrearPublicacion;
	DROP PROCEDURE [DE_UNA].DatosUsuarioLogueado;
	DROP PROCEDURE [DE_UNA].DesbloquearUsuario;
	DROP PROCEDURE [DE_UNA].EliminarUsuario;
	DROP PROCEDURE [DE_UNA].EliminarVisibilidad;
	DROP PROCEDURE [DE_UNA].FinalizaPublicaciones;
	DROP PROCEDURE [DE_UNA].GenerarFactura;
	DROP PROCEDURE [DE_UNA].GetClientes;
	DROP PROCEDURE [DE_UNA].GetDatosCabeceraFactura;
	DROP PROCEDURE [DE_UNA].GetEmpresas;
	DROP PROCEDURE [DE_UNA].GetEstadosPublicacion;
	DROP PROCEDURE [DE_UNA].GetFacturas;
	DROP PROCEDURE [DE_UNA].GetFuncionalidades;
	DROP PROCEDURE [DE_UNA].GetFuncionalidadesByRol;
	DROP PROCEDURE [DE_UNA].GetGridUsuarios;
	DROP PROCEDURE [DE_UNA].GetHistorial;
	DROP PROCEDURE [DE_UNA].GetItems;
	DROP PROCEDURE [DE_UNA].GetOfertas;
	DROP PROCEDURE [DE_UNA].GetOfertasUsuario;
	DROP PROCEDURE [DE_UNA].GetPublicacion;
	DROP PROCEDURE [DE_UNA].GetPublicaciones;
	DROP PROCEDURE [DE_UNA].GetRoles;
	DROP PROCEDURE [DE_UNA].GetRolesDeUsuario;
	DROP PROCEDURE [DE_UNA].GetRubro;
	DROP PROCEDURE [DE_UNA].GetRubros;
	DROP PROCEDURE [DE_UNA].GetTiposPublicacion;
	DROP PROCEDURE [DE_UNA].GetUsuario;
	DROP PROCEDURE [DE_UNA].GetVisibilidad;
	DROP PROCEDURE [DE_UNA].GetVisibilidades;
	DROP PROCEDURE [DE_UNA].Login;
	DROP PROCEDURE [DE_UNA].NuevaEmpresa;
	DROP PROCEDURE [DE_UNA].NuevaOferta;
	DROP PROCEDURE [DE_UNA].NuevaVisibilidad;
	DROP PROCEDURE [DE_UNA].NuevoCliente;
	DROP PROCEDURE [DE_UNA].NuevoRol;
	DROP PROCEDURE [DE_UNA].ReporteMayorCantidadFacturas;
	DROP PROCEDURE [DE_UNA].ReporteMayorCantProdComprados;
	DROP PROCEDURE [DE_UNA].ReporteMayorCantProdNoVendidos;
	DROP PROCEDURE [DE_UNA].ReporteMayorMontoFacturado;
	DROP PROCEDURE [DE_UNA].ResetPassword;
	DROP PROCEDURE [DE_UNA].SetRolInactivo;
	DROP PROCEDURE [DE_UNA].GetCompras;
	DROP PROCEDURE [DE_UNA].GetFactura;
	DROP PROCEDURE [DE_UNA].ReputacionVendedor;

	DROP FUNCTION  [DE_UNA].fn_Get_Reputacion_Vendedor
	DROP FUNCTION  [DE_UNA].fn_Cant_Compras_Por_Usuario
	DROP FUNCTION  [DE_UNA].fn_Compras_Sin_Calificar
	DROP FUNCTION  [DE_UNA].fn_Ultimas_5_Compras_Calificadas

	DROP TYPE [DE_UNA].FuncionalidadesList;
	DROP TYPE [DE_UNA].ListaNrosFacturas;
	DROP TYPE [DE_UNA].Rubros;

	DROP SCHEMA [DE_UNA];
END
GO
