using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace jukebox.webapi.Controllers
{
    [ApiController]
    // [Route("[controller]")]
    public class MusicController : ControllerBase
    {
        private Models.Music myMusic = new Models.Music();

        private readonly ILogger<MusicController> _logger;

        public MusicController(ILogger<MusicController> logger)
        {
            _logger = logger;
        }

        [HttpGet]
        [Route("[controller]")]
        public String Get()
        {
            return "<h1>Hello, this is my jukebox!</h1>";
        }

        [HttpGet]
        [Route("[controller]/Faith")]
        public String GetFaith()
        {
            return myMusic.Faith;
        }

        [HttpGet]
        [Route("[controller]/Queen")]
        public String GetQueen()
        {
            return myMusic.Queen;
        }
    }
}