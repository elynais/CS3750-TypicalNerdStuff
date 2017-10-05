using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(YouthFutureCMS.Startup))]
namespace YouthFutureCMS
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
