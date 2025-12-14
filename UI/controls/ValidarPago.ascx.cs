using System;
using System.Web.UI;

namespace UI.controls
{
    public partial class ValidarPago : UserControl
    {
        public string CardType => ddlCardType.SelectedValue;
        public string CardName => txtCardName.Text.Trim();
        public string CardNumber => txtCardNumber.Text.Trim();
        public string Expiration => txtExpDate.Text.Trim();
        public string CVV => txtCVV.Text.Trim();
    }
}
