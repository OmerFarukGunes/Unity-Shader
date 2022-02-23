Shader "Custom/38"
{
    Properties
    {
        _MainTex("Texture",2D) = "black" {}
    }
        SubShader
    {
        Tags { "Queue" = "Transparent" }
        Blend SrcAlpha OneMinusSrcAlpha
        Cull off //texture arkadanda görünür hale gelir
        Pass{
          SetTexture[_MainTex]{combine texture}
        }
    }
}
