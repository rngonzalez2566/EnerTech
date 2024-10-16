﻿using BE;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Tools
{
    public class ProductoTools
    {
        public static ProductoBE FillObjectProducto(DataRow dr)
        {
            ProductoBE producto = new ProductoBE();
            MarcaDAL marca = new MarcaDAL();
            CategoriaDAL categoria = new CategoriaDAL();
            producto.Marca = new MarcaBE();
            producto.Categoria = new CategoriaBE();


            if (dr.Table.Columns.Contains("Id") && !Convert.IsDBNull(dr["Id"]))
                producto.Id = Convert.ToInt32(dr["Id"]);

            if (dr.Table.Columns.Contains("Codigo") && !Convert.IsDBNull(dr["Codigo"]))
                producto.Codigo = Convert.ToString(dr["Codigo"]);

            if (dr.Table.Columns.Contains("Catalogo") && !Convert.IsDBNull(dr["Catalogo"]))
                producto.Catalogo = Convert.ToBoolean(dr["Catalogo"]);

            if (dr.Table.Columns.Contains("Descripcion") && !Convert.IsDBNull(dr["Descripcion"]))
                producto.Descripcion = Convert.ToString(dr["Descripcion"]);

            if (dr.Table.Columns.Contains("Cantidad") && !Convert.IsDBNull(dr["Cantidad"]))
                producto.Cantidad = Convert.ToInt32(dr["Cantidad"]);

            if (dr.Table.Columns.Contains("Imagen") && !Convert.IsDBNull(dr["Imagen"]))
                producto.Imagen = Convert.ToString(dr["Imagen"]);

            if (dr.Table.Columns.Contains("id_marca") && !Convert.IsDBNull(dr["id_marca"]))
                producto.Marca = marca.GetMarcaID(Convert.ToInt32(dr["id_marca"]));

            if (dr.Table.Columns.Contains("id_categoria") && !Convert.IsDBNull(dr["id_categoria"]))
                producto.Categoria = categoria.GetCategoriaID(Convert.ToInt32(dr["id_categoria"]));



            return producto;
        }

        public static List<ProductoBE> FillListProducto(DataSet ds)
        {
            return ds.Tables[0].AsEnumerable().Select(dr => FillObjectProducto(dr)).ToList();
        }
    }
}