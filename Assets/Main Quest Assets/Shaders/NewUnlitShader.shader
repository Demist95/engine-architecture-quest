Shader "Unlit/NewUnlitShader"
{
	Properties{
		_MainTex("Base (RGB)", 2D) = "" {}
		_FlowMap("Flow Map", 2D) = "" {}
		_Speed("Speed", Range(-1, 1)) = 0.2
	}

		SubShader{
			Pass {
				Tags { "RenderType" = "Opaque" }

				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#include "UnityCG.cginc"

				struct v2f {
					float4 pos : SV_POSITION;
					fixed2 uv : TEXCOORD0;
				};

				sampler2D _MainTex;
				sampler2D _FlowMap;
				fixed _Speed;

				fixed4 _MainTex_ST;

					v2f vert(appdata_base v) {
						v2f o;
						v.vertex.x += sign(v.vertex.x) * sin(_Time.w) / 50;
						v.vertex.y += sign(v.vertex.y) * cos(_Time.w) / 50;
						o.pos = UnityObjectToClipPos(v.vertex);
						o.uv = v.texcoord;
						return o;
					}

				fixed4 frag(v2f v) : COLOR {
					fixed4 c;
					half3 flowVal = (tex2D(_FlowMap, v.uv) * 2 - 1) * _Speed;

					float dif1 = frac(_Time.y * 0.25 + 0.5);
					float dif2 = frac(_Time.y * 0.25);

					half lerpVal = abs((0.5 - dif1) / 0.5);

					half4 col1 = tex2D(_MainTex, v.uv - flowVal.xy * dif1);
					half4 col2 = tex2D(_MainTex, v.uv - flowVal.xy * dif2);

					c = lerp(col1, col2, lerpVal);
					return c;
				}

				ENDCG
			}
		}
			FallBack "Diffuse"
}