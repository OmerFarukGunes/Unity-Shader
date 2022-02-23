Shader "Custom/Wave" {
    Properties{
        _MainTex("Base (RGB)", 2D) = "white" {}
        _myBump("Bump Texture", 2D) = "bump" {}
        _Amplitude("Amplitude", Float) = 1
        _Wavelength("Wavelength", Float) = 10
        _Speed("Speed", Float) = 1
    }
        SubShader{
            Tags { "RenderType" = "Opaque" }
            LOD 200

            CGPROGRAM
            #pragma surface surf Lambert vertex:vert
            sampler2D _MainTex;
            sampler2D _myBump;
            float4 _myBump_ST;
            float4 _MainTex_ST;
            half _Glossiness;
            half _Metallic;
            float _Amplitude, _Wavelength, _Speed;
            struct Input {
                float2 st_MainTex;
                float2 st_myBump;
            };

            void vert(inout appdata_full v, out Input o)
            {
                UNITY_INITIALIZE_OUTPUT(Input,o);

                o.st_MainTex = TRANSFORM_TEX(v.texcoord, _MainTex);
                o.st_myBump = TRANSFORM_TEX(v.texcoord, _myBump);

                o.st_MainTex.x += sin((o.st_MainTex.x + o.st_MainTex.y) * 8 + _Time.g * 1.3) * 0.01;
                o.st_myBump.x += sin((o.st_myBump.x + o.st_myBump.y) * 8 + _Time.g * 1.3) * 0.01;
                o.st_MainTex.y += cos((o.st_MainTex.x - o.st_MainTex.y) * 8 + _Time.g * 2.7) * 0.01;
                o.st_myBump.y += cos((o.st_myBump.x - o.st_myBump.y) * 8 + _Time.g * 2.7) * 0.01;

                float3 p = v.vertex.xyz;

                float k = 2 * UNITY_PI / _Wavelength;
                p.y = _Amplitude * sin(k * (p.x - _Speed * _Time.y));

                v.vertex.xyz = p;
            }

            void surf(Input IN, inout SurfaceOutput  o) {
                half4 c = tex2D(_MainTex, IN.st_MainTex);
                o.Albedo = c.rgb;
                o.Alpha = c.a;
                o.Normal = UnpackNormal(tex2D(_myBump, IN.st_myBump));
            }
            ENDCG
    }
        FallBack "Diffuse"
}
