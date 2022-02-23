Shader "Custom/ScaleUI" {
    Properties{
        _MainTex("Base (RGB)", 2D) = "white" {}
        _Color("Color", Color) = (1,1,1,1)
        _Scale("Scale", Float) = 1.0
    }
        SubShader{
            Tags { "RenderType" = "Opaque"  }

        CGPROGRAM
        #pragma surface surf Lambert

        struct Input {
            float3 worldNormal;
            float3 worldPos;
            float2 uv_MainTex;
        };

        sampler2D _MainTex;
        fixed4 _Color;
        float _Scale;

        void surf(Input IN, inout SurfaceOutput o) {
            float2 UV;
            fixed4 c;

            if (abs(IN.worldNormal.x) > 0.5) {
                UV = IN.worldPos.yz; 
                c = tex2D(_MainTex, UV  * _Scale);
            }
            else if (abs(IN.worldNormal.z) > 0.5) {
                UV = IN.worldPos.xy;
                c = tex2D(_MainTex, UV * _Scale); 
            }
            else {
                UV = IN.worldPos.xz;
                c = tex2D(_MainTex, UV * _Scale); 
            }
            o.Albedo = c.rgb * _Color;
        }
        ENDCG
        }
        FallBack "Diffuse"
}