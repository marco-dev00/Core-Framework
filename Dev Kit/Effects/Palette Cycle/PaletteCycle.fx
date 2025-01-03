sampler2D img;
sampler2D Palettes = sampler_state {
	MinFilter = Point;
	MagFilter = Point;
};


int nPal, lerpA, lerpB;
float lerpVal;


float4 PixelPalette(float2 texCoord : TEXCOORD ) : COLOR
{
	float4 output = tex2D(img, texCoord);
	float colorIndex = -1;

	for(int i=0;i<32 && output.a > 0.0;i++)
	{
		float4 OriginalPalette = tex2D(Palettes, float2(i/256.0,0.0));
		// i = OriginalPalette.a > 0.0 ? 16 : i;
		if( distance(output.rgb, OriginalPalette.rgb) == 0 )
		{
			colorIndex = i/256.0;
		}
	}

	if(colorIndex > -1)
	{
		float4 colorA = tex2D(Palettes, float2(colorIndex, lerpA / float(nPal)));
		float4 colorB = tex2D(Palettes, float2(colorIndex, lerpB / float(nPal)));
		output.rgb = lerp(colorA, colorB, lerpVal);
	}

	return output;
}

technique tech_main
{
	pass p0
	{
		VertexShader = null;
		PixelShader = compile ps_2_a PixelPalette();
	}
}