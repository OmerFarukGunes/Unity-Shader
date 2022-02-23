Shader "Custom/37_Blending"
{
    Properties
    {
        _MainTex("Texture",2D) = "black" {}
    }
        SubShader
    {
        Tags { "Queue" = "Transparent" }
        //Blend One One //ilk gelen data ile bufferdan gelen ilk datayı blendler
        //Blend SrcAlpha OneMinusSrcAlpha //sadece siyah yerlerr transparan olur
        //Blend DstColor Zero //heryer transparan olur beyazlar yok olur.
        //Blend DstColor One //beyaza yakın bir transparanlık olur.

        Pass{
          SetTexture [_MainTex]{combine texture}
        }
    }   
}
