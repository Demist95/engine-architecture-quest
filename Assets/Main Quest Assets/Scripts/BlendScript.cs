using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BlendScript : MonoBehaviour
{

    Renderer rend;
    float val;
    bool increment;

    void Start()
    {
        rend = GetComponent<Renderer>();

        rend.material.shader = Shader.Find("Unlit/BodyShader");

        val = 0.0f;
        increment = true;
    }

    void Update()
    {
        if (val >= 1)
            increment = false;
        else if (val <= 0)
            increment = true;

        if (increment)
        {
            Increment();
        } 

        else
        {
            Decrement();
        }
    }

    void Increment()
    {
        rend.material.SetFloat("_Blend", val);
        val += 0.005f;
    }

    void Decrement()
    {
        rend.material.SetFloat("_Blend", val);
        val -= 0.005f;
    }
}
