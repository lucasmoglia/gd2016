using ME.Data;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ME.Business
{
    public class ListadoEstadisticoHandler
    {
        /*Vendedores con mayor monto facturado dentro de un mes y año particular*/
        public static List<ListadoEstadistico> GetReporteVMMF(string mes, string anio)
        {
            return ListadoEstadistico.GetReporteVMMF(mes, anio);
        }

        /*Vendedores con mayor cantidad de facturas dentro de un mes y año particular*/
        public static List<ListadoEstadistico> GetReporteVMCF(string mes, string anio)
        {
            return ListadoEstadistico.GetReporteVMCF(mes, anio);
        }

        /*Clientes con mayor cantidad de productos comprados, por mes y por año, dentro de un rubro particular*/
        public static List<ListadoEstadistico> GetReporteCMCPC(string mes, string anio, int rubro)
        {
            return ListadoEstadistico.GetReporteCMCPC(mes, anio, rubro);
        }

        /*Vendedores con mayor cantidad de facturas dentro de un **trimestre** y año particular*/
        public static List<ListadoEstadistico> GetReporteVMCPNV(string mes, string anio, int visibilidad)
        {
            return ListadoEstadistico.GetReporteVMCPNV(mes, anio, visibilidad);
        }
    }
}
