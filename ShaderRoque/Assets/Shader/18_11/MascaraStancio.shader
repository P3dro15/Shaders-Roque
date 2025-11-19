Shader "Custom/MascaraStancio"
{
    Properties
    {
        [IntRange] _Ref("Ref", Range(0,255)) = 1
        [Enum(UnityEngine.Rendering.CompareFunction)] _Comp("Comp", Int) = 0
        [Enum(UnityEngine.Rendering.StencilOp)] _Op1("Operation", Int) = 0
        [Enum(UnityEngine.Rendering.StencilOp)] _Op2("Fail", Int) = 0
    }
    SubShader
    {
        
        // Stencil
        // {
        //     Ref 1
        //     Comp Equal
        //     Pass Keep
        //     fail Replace
        // }
       Pass
       {
            ColorMask 0
            ZWrite Off
            Stencil
            {
                Ref [_Ref]
                Comp [_Comp]
                Pass [_Op1]
                Fail [_Op2]
            }
       }
    }
}
