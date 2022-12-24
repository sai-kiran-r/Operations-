using System;
using System.IO;

namespace jukebox.webapi.Models
{
    public class Music
    {
        public string Faith { get; set; }
        public string Queen { get; set;} 
        public Music()
        {
            if (File.Exists("faith.txt"))
            {
                Faith = File.ReadAllText("faith.txt");
            }
            else
            {
                Faith = "??";
            }

            if (File.Exists("queen.txt"))
            {
                Queen = File.ReadAllText("queen.txt");
            }
            else
            {
                Queen = "??";
            }
        }
    }
}
