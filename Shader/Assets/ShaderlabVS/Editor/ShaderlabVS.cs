using UnityEngine;
using UnityEditor;
using System.IO;
using System.Diagnostics;
using System.Text;
using System.Linq;

namespace ShaderlabVS
{
    public class Shaderlab
    {
        [MenuItem("Tools/ShaderlabVS Pro/Download Visual Studio")]
        public static void DownloadVS()
        {
            Application.OpenURL("https://visualstudio.microsoft.com/");
        }

        [MenuItem("Tools/ShaderlabVS Pro/Online Manual")]
        public static void OpenOnlineManual()
        {
            Application.OpenURL("https://www.amlovey.com/shaderlabvs/");
        }

        [MenuItem("Tools/ShaderlabVS Pro/Star And Review")]
        public static void StarAndReview()
        {
            Application.OpenURL("https://assetstore.unity.com/packages/slug/186176?aid=1011lGoJ");
        }

        #region Script Templates

        [MenuItem("Tools/ShaderlabVS Pro/Install Script Templates", false, 44)]
        public static void InstallScriptTemplatesMenu()
        {
            InstallScriptTemplates();
            EditorUtility.DisplayDialog("Success", "Script templates will available after Unity Editor restared", "Ok");
        }

        private static void InstallScriptTemplates()
        {
            int order = 90;
            string category = "Shader";
            string srcFolderInProject = GetScriptTemplatesFolderInProject();
            string targetFolderInUnity = GetScriptTemplatesFolderOfUnity();
            StringBuilder sb = new StringBuilder();

            var ingoreFiles = new string[] { "90-Shader__Compute Shader-NewComputeShader.compute" };

            // Clear template folder
            var files = Directory.GetFiles(targetFolderInUnity);
            var needToDeleteFiles = files.Where(f =>
            {
                var fileName = Path.GetFileNameWithoutExtension(f);
                if (fileName.StartsWith("90-Shader_"))
                {
                    if (ingoreFiles.Any(ignoreFile => ignoreFile.Equals(fileName, System.StringComparison.OrdinalIgnoreCase)))
                    {
                        return false;
                    }

                    return true;
                }

                return false;
            });

            foreach (var item in needToDeleteFiles)
            {
                sb.AppendLine(string.Format("del /q \"{0}\"", Path.GetFullPath(item)));
            }

            // Copy templates to template folder of Unity
            foreach (var template in Directory.GetFiles(srcFolderInProject, "*.txt"))
            {
                var templateName = Path.GetFileNameWithoutExtension(template);
                var temp = templateName.Split(new char[] { '-' }, 2);
                var nameInMenu = temp[0];
                var fileName = temp[1];

                if (!string.IsNullOrEmpty(nameInMenu) && !string.IsNullOrEmpty(fileName))
                {
                    var dstFileName = string.Format("{0}-{1}__{2}-{3}.txt", order, category, nameInMenu, fileName);
                    sb.AppendLine(string.Format("copy /Y \"{0}\" \"{1}\"", Path.GetFullPath(template), Path.GetFullPath(Path.Combine(targetFolderInUnity, dstFileName))));
                }
            }

            var batchFile = Path.GetFullPath(Path.Combine(Application.dataPath, "..", "Library", "cp.bat"));
            File.WriteAllText(batchFile, sb.ToString(), Encoding.ASCII);

            ProcessStartInfo startInfo = new ProcessStartInfo();
            startInfo.FileName = batchFile;
            startInfo.Verb = "runas";
            startInfo.CreateNoWindow = true;
            startInfo.UseShellExecute = true;
            Process.Start(startInfo);
        }

        private static string GetScriptTemplatesFolderInProject()
        {
            return Path.Combine(Application.dataPath, "ShaderlabVS", "ScriptTemplates");
        }

        private static string GetScriptTemplatesFolderOfUnity()
        {
            var contentsPath = EditorApplication.applicationContentsPath;
            return Path.Combine(contentsPath, "Resources", "ScriptTemplates");
        }
        #endregion
    }
}