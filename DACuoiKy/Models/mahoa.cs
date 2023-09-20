using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Security.Cryptography;
using System.Text;

namespace DACuoiKy.Models
{
    public class mahoa
    {
        /// <summary>
        /// Ham Phuc cho muc dich ma hoa mot chuoi va ban goc dua vao viec bam du lieu boi SHA256
        /// </summary>
        /// <param name="PlainText"> Chuoi van ban ma hoa</param>
        /// <returns> Ket qua da ma hoa </returns>
        public static string encryptSHA256(string PlainText)
        {
            string result = "";
            /// create a SHA256 --------------
            using (SHA256 bb = SHA256.Create())
            {
                //--- convert plain text to a byte array
                byte[] sourceData = Encoding.UTF8.GetBytes(PlainText);
                //--- compute Hash and return a byte array----------
                byte[] hashResult = bb.ComputeHash(sourceData);
                result = BitConverter.ToString(hashResult);
            }
            return result;
        }
    }
}