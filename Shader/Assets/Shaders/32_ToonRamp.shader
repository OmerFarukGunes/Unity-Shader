Shader "Custom/32_BasicBlinn"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_RampTex("Ramp Texture", 2D) = "White"{}
	}
		SubShader
	{
		Tags { "Queue" = "Geometry" }


		CGPROGRAM

		#pragma surface surf ToonRamp

		float4 _Color;
		sampler2D _RampTex;

		half4 LightingToonRamp(SurfaceOutput s, fixed3 lightDir,fixed atten) {
			half diff = max(0, dot(s.Normal, lightDir));
			half3 h = diff * 0.5 + 0.5;
			float2 rh = h;
			float3 ramp = tex2D(_RampTex, rh).rgb;
			float4 c;
			c.rgb = s.Albedo * _LightColor0.rgb * (ramp);
			c.a = s.Alpha;
			return c;
		}

		

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = _Color.rgb;
		}
		ENDCG
	}
		FallBack "Diffuse"
}
