using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Gaia.Ajax.UI.WebControls.VideoPlayers;
using Gaia.WebWidgets;

namespace Asseponto.Clientes
{
    public partial class videos : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            pnlModal.Aspects.Add(new AspectModal(Color.Black, 0.5D));
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetCurrentVideo();
            }
        }

        private void SetCurrentVideo()
        {
            flowplayer.VideoFile = "http://www.assecont.com.br/suporte/VideosTreinamento/Metallica - Nothing Else Matters.flv";
            flowplayer.ControlsOverVideo = false;
            flowplayer.ShowFullScreenButton = true;
            flowplayer.AutoPlay = false;
        }

        /// <summary>
        /// FlowPlay dispatches this event when the state of the Player changes
        /// </summary>
        protected void flowplayer_StateChanged(object sender, FlowPlayer.StatusChangedEventArgs e)
        {
            lblStatus.Text = e.CurrentState == FlowPlayer.PlayerState.Paused ? "Video pausado" : "";
        }

        /// <summary>
        /// Dispatched when a cue point is reached
        /// </summary>
        protected void flowplayer_CuePointReached(object sender, FlowPlayer.CuePointReachedEventArgs e)
        {
            switch (e.CuePoint.Name)
            {
                case "ShowPanel":
                    pnlModal.Visible = true;
                    flowplayer.Pause();
                    break;
            }
        }

        protected void flowplayer_VideoClipFinished(object sender, EventArgs e)
        {
            SetCurrentVideo();
            flowplayer.UpdatePlayer();
        }

        protected void ClosePanel(object sender, EventArgs e)
        {
            pnlModal.Visible = false;
            flowplayer.Play();
        }

        protected void UpdatePlayer(object sender, EventArgs e)
        {
            SetCurrentVideo();
            flowplayer.UpdatePlayer();
        }
    }
}