using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System;

namespace ME.Data
{
    public static class Globales
    {
        public static Int32 TamanioPag_Publi { get; set; }
        public static Int32 NumPag_Publi { get; set; }
        public static Int32 TotalPags_Publi { get; set; }
        public static Int32 PagsEnCache_Publi { get; set; }
    }

    public static class UserLogged
    {
        public static decimal cod_usuario { get; set; }
        public static string username { get; set; }
        public static bool activo { get; set; }
        public static bool esAdmin { get; set; }
        public static bool esEmpresa { get; set; }
        public static bool publ_sin_cargo { get; set; }
        public static List<Rol> roles = new List<Rol>();
        public static List<FuncionalidadModel> funcionalidades = new List<FuncionalidadModel>();
        public static decimal cod_rol_seleccionado
        {
            get
            {
                return cod_rol_seleccionado;
            }
            set
            {
                cod_rol_seleccionado = value;
                funcionalidades = Funcionalidad.GetFuncionalidadesByRol(value);
            }
        }

        //static UserLogged(decimal unCod_usuario, string unUsername, bool unEsAdmin, bool unEsEmpresa, List<FuncionalidadModel> unasFuncionalidades)
        //{
        //    cod_usuario = unCod_usuario;
        //    username = unUsername;
        //    esAdmin = unEsAdmin;
        //    esEmpresa = unEsEmpresa;
        //    funcionalidades = unasFuncionalidades;
        //}
    }

    public class ObjectUserLogged
    {
        public decimal cod_usuario { get; set; }
        public string username { get; set; }
        public bool activo { get; set; }
        public bool esAdmin { get; set; }
        public bool esEmpresa { get; set; }
        public bool publ_sin_cargo { get; set; }
        public List<Rol> roles { get; set; }

        public ObjectUserLogged(decimal cod_usuario, string username, bool activo, bool esAdmin, 
                                 bool esEmpresa, bool publ_sin_cargo, List<Rol> roles)
        {
            this.cod_usuario = cod_usuario;
            this.username = username;
            this.activo = activo;
            this.esAdmin = esAdmin;
            this.esEmpresa = esEmpresa;
            this.publ_sin_cargo = publ_sin_cargo;
            this.roles = roles;
        }

        public static ObjectUserLogged DatosUsuarioLogueado(string username)
        {
            using (SqlConnection connection = MEEntity.GetConnection())
            {
                SqlCommand command = new SqlCommand("[DE_UNA].[DatosUsuarioLogueado]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@username", SqlDbType.NVarChar).Value = username;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read()){
                    decimal cod_usuario = decimal.Parse(reader["cod_usuario"].ToString());
                    //List<Rol> rolesUsuario = RolHandler.RolesDeUsuario(cod_usuario);
                    List<Rol> rolesUsuario = Rol.GetRolesDeUsuario(cod_usuario);

                    rolesUsuario.ForEach(rol => rol.funcionalidades = new List<FuncionalidadModel>());
                    rolesUsuario.ForEach(rol => rol.funcionalidades.AddRange(Funcionalidad.GetFuncionalidadesByRol(rol.cod_rol)));


                    bool activo = bool.Parse(reader["activo"].ToString());// == 0 ? false : true;
                    bool esEmpresa = int.Parse(reader["esEmpresa"].ToString()) == 0 ? false : true;
                    bool publi_sin_cargo = bool.Parse(reader["publ_sin_cargo"].ToString());// == 0 ? false : true;

                    List<Rol> Ro = rolesUsuario;
                    
                    ObjectUserLogged unUserLogged = new ObjectUserLogged(
                          cod_usuario
                        , username
                        , bool.Parse(reader["activo"].ToString())
                        , username == "admin" ? true : false
                        , byte.Parse(reader["esEmpresa"].ToString()) == 0 ? false : true
                        , bool.Parse(reader["publ_sin_cargo"].ToString())
                        , rolesUsuario != null ? rolesUsuario : null
                    );

                    return unUserLogged;
                } else {
                    return null;
                }
            }
        }

    }
}
