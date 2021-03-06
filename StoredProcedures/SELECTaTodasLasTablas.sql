SELECT *, 'Usuarios' FROM [DE_UNA].[Usuarios];
SELECT *, 'Clientes' FROM [DE_UNA].[Clientes] ORDER BY dni;
SELECT *, 'Empresas' FROM [DE_UNA].[Empresas];
SELECT *, 'Compras' FROM [DE_UNA].[Compras];
SELECT *, 'EstadosPublicacion' FROM [DE_UNA].[EstadosPublicacion];
SELECT *, 'Func_por_Rol' FROM [DE_UNA].[Func_por_Rol];
SELECT *, 'Funcionalidades' FROM [DE_UNA].[Funcionalidades];
SELECT *, 'Facturas' FROM [DE_UNA].[Facturas];
SELECT *, 'Items' FROM [DE_UNA].[Items];
SELECT *, 'Ofertas' FROM [DE_UNA].[Ofertas];
SELECT *, 'Publicaciones' FROM [DE_UNA].[Publicaciones];
SELECT *, 'Roles' FROM [DE_UNA].[Roles];
SELECT *, 'Roles_Usuario' FROM [DE_UNA].[Roles_Usuario];
SELECT *, 'Rubros' FROM [DE_UNA].[Rubros];
SELECT *, 'Tipos_Publicacion' FROM [DE_UNA].[Tipos_Publicacion];
SELECT *, 'Visibilidades' FROM [DE_UNA].[Visibilidades];

-- Para desbloquear el usuario.
UPDATE [DE_UNA].Usuarios
   SET login_fallidos = 0,
	   activo = 1
 WHERE username = 'admin';
