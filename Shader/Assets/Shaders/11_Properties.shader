Shader "Holistic/11_Properties" {

	Properties{
		_myColour("Example Colour", Color) = (1,1,1,1)
		_myEmission("Example Emission", Color) = (1,1,1,1)
		_myRange("Example Range", Range(0,5)) = 1
		_myTex("Example Tex", 2D) = "White" {}
		_myCube("Example Cube", Cube) = ""{}
		_myFloat("Example Float", Float) = 0.5
		_myVector("Example Vector", Vector) = (0.5,1,1,1)
	}
		SubShader{

			CGPROGRAM
				#pragma surface surf Lambert

				fixed4 _myColour;
				fixed4 _myEmission;
				half _myRange;
				sampler2D _myTex;
				samplerCUBE _myCube;
				float _myFloat;
				float4 _myVector;

				struct Input {
					float2 uv_myTex;
					float3 worldRefl;
				};



				void surf(Input IN, inout SurfaceOutput o) {
					o.Albedo = (tex2D(_myTex, IN.uv_myTex).rgb * _myRange).rgb;
					o.Emission = texCUBE(_myCube, IN.worldRefl).rgb;
				}

			ENDCG
		}
			FallBack "Diffuse"
}