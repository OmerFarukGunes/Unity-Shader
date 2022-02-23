Shader "Custom/48_AdvanceOutline"
{
    Properties
    {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _OutlineColor("Outline Color",Color) = (0,0,0,1)
        _Outline("Outline Width",Range(-0.1,0.1)) = .005

    }
        SubShader
        {
           
            CGPROGRAM
                // Physically based Standard lighting model, and enable shadows on all light types
                #pragma surface surf Lambert

                sampler2D _MainTex;

                struct Input
                {
                    float2 uv_MainTex;
                };



                void surf(Input IN, inout SurfaceOutput o)
                {
                    // Albedo comes from a texture tinted by color
                    fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
                    o.Albedo = c.rgb;
                }
                ENDCG
                PASS{
                    Cull Front //ÖN YÜZÜ KESER
                    CGPROGRAM
                    #pragma vertex vert
                    #pragma fragment frag
                    #include "UnityCG.cginc"
                    struct appdata {
                    float4 vertex: POSITION;
                    float3 normal: NORMAL;
};
                    struct v2f {
                        float4 pos:SV_POSITION;
                        fixed4 color : COLOR;
                    };
                    float _Outline;
                    float4 _OutlineColor;
                    v2f vert(appdata v) {
                        v2f o;
                        o.pos = UnityObjectToClipPos(v.vertex);
                        float3 norm = normalize(mul((float3x3) UNITY_MATRIX_IT_MV, v.normal));
                        float2 offset = TransformViewToProjection(norm.xy);
                        o.pos.xy += offset * o.pos.z * _Outline;
                        o.color = _OutlineColor;
                        return o;
                    }
                    fixed4 frag(v2f i) :SV_Target{
                        return i.color;
                    }
                    ENDCG
                }

        }
            FallBack "Diffuse"
}
