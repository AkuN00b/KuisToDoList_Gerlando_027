<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="KuisToDoList_Gerlando_027.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Barlow:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
    <link href="./style.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <div>
            <table border="1" class="table1">
                <tr>
                    <td align="center">
                        <h1 class="titleText">To-do List</h1>
                    </td>
                </tr>
            </table>
            <br />

            <table border="1" class="table2">
                <tr class="rowTable">
                    <td width="50%" style="padding-right: 20px;">
                        <h1 class="title" align="center">Create Task</h1>
                        <hr />
                    </td>

                    <td width="50%" style="padding-left: 20px;" class="sisiKanan">
                        <h1 class="title" align="center">Task List</h1>
                        <hr />
                    </td>
                </tr>

                <tr class="rowTable">
                    <td width="50%" style="padding-right: 20px;">
                        <label>
                            Task Name<span class="req-val">*</span><asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="txtTaskName"
                                ErrorMessage="!!!" ForeColor="Red" ValidationGroup="kirimTDL"></asp:RequiredFieldValidator>
                        </label>
                        <asp:TextBox runat="server" ID="txtTaskName" CssClass="inputName"></asp:TextBox>
                    </td>

                    <td width="50%" style="padding-left: 20px;" class="sisiKanan">
                        <h3 align="left">Not Done</h3>
                        <asp:GridView runat="server" ID="gridData" AutoGenerateColumns="false" EmptyDataText="-"
                            ShowHeader="false" ShowHeaderWhenEmpty="false" AllowPaging="false" AllowSorting="false"
                            DataKeyNames="id" OnRowCommand="gridData_RowCommand" GridLines="None">
                            <Columns>
                                <asp:BoundField DataField="rownum" ItemStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="name" ItemStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="priorityLevel" ItemStyle-HorizontalAlign="Left" />
                                <asp:TemplateField HeaderText="Aksi" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnUbah" CommandName="Check" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'><i class="bi bi-check"></i></asp:LinkButton>&nbsp;
                            <asp:LinkButton ID="btnHapus" CommandName="Hapus" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'><i class="bi bi-trash"></i></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>

                <tr class="rowTable">
                    <td width="50%" style="padding-right: 20px;">
                        <label>
                            Priority<span class="req-val">*</span><asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="ddJenisKelamin"
                                ErrorMessage="!!!" ForeColor="Red" ValidationGroup="kirimTDL"></asp:RequiredFieldValidator>
                        </label>
                        <asp:DropDownList ID="ddJenisKelamin" runat="server" CssClass="inputSelect">
                            <asp:ListItem Text="-- Choose --" Value="" Selected Disabled></asp:ListItem>
                            <asp:ListItem Text="High" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Medium" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Low" Value="3"></asp:ListItem>
                        </asp:DropDownList>
                    </td>

                    <td width="50%" style="padding-left: 20px;" class="sisiKanan">
                        <h3 align="left">Done</h3>
                        <asp:GridView runat="server" ID="GridView1" AutoGenerateColumns="false" EmptyDataText="-"
                            ShowHeader="false" ShowHeaderWhenEmpty="false" AllowPaging="false" AllowSorting="false"
                            DataKeyNames="id" OnRowCommand="GridView1_RowCommand" GridLines="None">
                            <Columns>
                                <asp:BoundField DataField="rownum" ItemStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="name" ItemStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="priorityLevel" ItemStyle-HorizontalAlign="Left" />
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>

                <tr class="rowTable">
                    <td width="50%" style="padding-right: 20px;">
                        <asp:Button Text="Submit" runat="server" ID="submitToDoList" OnClick="submitToDoList_Click" ValidationGroup="kirimTDL" CssClass="buttonKirim" />
                    </td>

                    <td width="50%" style="padding-left: 20px;" class="sisiKanan"></td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
