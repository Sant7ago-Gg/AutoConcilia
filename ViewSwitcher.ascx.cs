using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.FriendlyUrls;

namespace AutoConcilia1
{
    public partial class ViewSwitcher : System.Web.UI.UserControl
    {
        protected string CurrentView { get; private set; }
        protected string AlternateView { get; private set; }
        protected string SwitchUrl { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Determine current view
            var isMobile = Request.Browser.IsMobileDevice;
            CurrentView = isMobile ? "Mobile" : "Desktop";
            AlternateView = isMobile ? "Desktop" : "Mobile";

            // Create switch URL from the route
            var switchViewRouteName = "AspNet.FriendlyUrls.SwitchView";
            var switchViewRoute = RouteTable.Routes[switchViewRouteName];

            if (switchViewRoute == null)
            {
                this.Visible = false;
                return;
            }

            var url = GetRouteUrl(switchViewRouteName, new { view = AlternateView });

            if (string.IsNullOrEmpty(url))
            {
                this.Visible = false;
                return;
            }

            url += "?ReturnUrl=" + HttpUtility.UrlEncode(Request.RawUrl);
            SwitchUrl = url;

        }
    }
}
