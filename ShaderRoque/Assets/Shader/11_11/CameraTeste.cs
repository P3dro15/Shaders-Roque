using UnityEngine;

public class CameraTeste : MonoBehaviour
{
   public Material mat;

   void OnRenderImage(RenderTexture source, RenderTexture destination){
    Graphics.Blit(source,destination,mat);
   }
}
