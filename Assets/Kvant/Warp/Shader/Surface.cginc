//
// Kvant/Warp - Warp (hyperspace) light streaks effect
//
// Copyright (C) 2016 Keijiro Takahashi
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#include "Common.cginc"

half3 _Emission;
float _NormalizedTime;

struct appdata
{
    float4 vertex : POSITION;
    float3 uvw : TEXCOORD0; // (line ID, random0, random1)
};

struct v2f
{
    float4 vertex : SV_POSITION;
    UNITY_FOG_COORDS(0)
};

v2f vert(appdata v)
{
    float3 p = ApplyLineParams(v.vertex.xyz, v.uvw);
    p += GetLinePosition(v.uvw, _NormalizedTime);

    v2f o;
    o.vertex = UnityObjectToClipPos(float4(p, 1));
    UNITY_TRANSFER_FOG(o, o.vertex);
    return o;
}

half4 frag(v2f i) : SV_Target
{
    half4 col = half4(_Emission, 1);
    UNITY_APPLY_FOG(i.fogCoord, col);
    return col;
}
