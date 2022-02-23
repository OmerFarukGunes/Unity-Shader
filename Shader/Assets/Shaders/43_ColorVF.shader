Shader "Unlit/43_ColorVF"
{
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 color: COLOR;
            };
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                //o.color.r = (v.vertex.x+10)/20; // renklerin x ekseninde nereye kadar gideceğini belirtir. Burası her bir vertexi temsil eder.
                //o.color.g = (v.vertex.z+10)/20;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = i.color;
                col.r = i.vertex.x / 1000;
                col.g = i.vertex.y / 1000; //birebir aynı formülü yazsan aynı çıktıyı alamazsın v2f vert fonksiyonunda ki gibi. Burası her bir pikseli temsil eder ve 0-1 arası değer alır
                return col;
            }
            ENDCG
        }
    }
}
