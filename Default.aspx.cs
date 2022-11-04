using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace KuisToDoList_Gerlando_027
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadDataDone();
                loadDataNotDone();
            }

            gridData.Width = Unit.Percentage(100);
            GridView1.Width = Unit.Percentage(100);
        }

        protected void loadDataDone()
        {
            DataTable dt = new DataTable();

            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            connection.Open();

            SqlCommand cmd = new SqlCommand("sp_getDone", connection);
            cmd.CommandType = CommandType.StoredProcedure;
            dt.Load(cmd.ExecuteReader());

            

            gridData.DataSource = dt;
            gridData.DataBind();

            connection.Close();
        }

        protected void loadDataNotDone()
        {
            DataTable dt = new DataTable();

            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            connection.Open();

            SqlCommand cmd = new SqlCommand("sp_getNotDone", connection);
            cmd.CommandType = CommandType.StoredProcedure;
            dt.Load(cmd.ExecuteReader());

            GridView1.DataSource = dt;
            GridView1.DataBind();

            connection.Close();
        }

        protected void deleteToDoList(string id)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                conn.Open();

                //SqlCommand command =
                //    new SqlCommand("delete from karyawan where id = " + id + ";", conn);

                //SqlDataAdapter adapter = new SqlDataAdapter();

                //adapter.DeleteCommand = command;
                //adapter.DeleteCommand.ExecuteNonQuery();

                SqlCommand command = new SqlCommand("sp_DeleteToDoList", conn);
                command.Parameters.AddWithValue("@id", id);
                command.CommandType = CommandType.StoredProcedure;
                dt.Load(command.ExecuteReader());

                conn.Close();

                loadDataNotDone();
                loadDataDone();
            }
            catch { }
        }

        protected void gridData_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "Page")
            {
                string tempId = gridData.DataKeys[Convert.ToInt32(e.CommandArgument)].Value.ToString();

                if (e.CommandName == "Hapus")
                {
                    deleteToDoList(tempId);
                }
                else if (e.CommandName == "Check")
                {

                    DataTable dt = new DataTable();

                    SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                    conn.Open();

                    // SqlCommand command = new SqlCommand("select npk, nama, provinsi from karyawan where id = '" + tempId + "';", conn);

                    SqlCommand command = new SqlCommand("sp_ChangeStatus", conn);
                    command.Parameters.AddWithValue("@id", tempId);
                    command.CommandType = CommandType.StoredProcedure;

                    dt.Load(command.ExecuteReader());

                    conn.Close();

                    loadDataDone();
                    loadDataNotDone();
                }
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {

        }

        protected void submitToDoList_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                conn.Open();

                //SqlCommand command =
                //    new SqlCommand("insert into karyawan (npk, nama, provinsi)" +
                //    "values ('" + txtNPK.Text + "', '" + txtNama.Text + "', '" + ddProvinsi.SelectedItem.Text + "');", conn);

                //SqlDataAdapter adapter = new SqlDataAdapter();

                //adapter.InsertCommand = command;
                //adapter.InsertCommand.ExecuteNonQuery();

                SqlCommand command = new SqlCommand("sp_InsertToDoList", conn);
                command.Parameters.AddWithValue("@name", txtTaskName.Text);
                command.Parameters.AddWithValue("@priority", ddJenisKelamin.SelectedValue);
                command.CommandType = CommandType.StoredProcedure;
                dt.Load(command.ExecuteReader());

                conn.Close();

                loadDataNotDone();
                loadDataDone();
            }
            catch { }
        }
    }
}