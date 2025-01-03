sampler2D img : register(s1);

float fFreq, fPeriods, fAmplitude;

//Main Shader Function
float4 ps_main(in float2 In : TEXCOORD0) : COLOR0 {

float2 uv = float2(In.x + (sin((In.y + fFreq) * fPeriods) * fAmplitude), In.y);

float4 color = tex2D(img, uv);

    return color;

}

technique tech_main { pass P0 { PixelShader = compile ps_2_a ps_main(); } }