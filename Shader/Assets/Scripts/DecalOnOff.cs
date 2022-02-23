using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DecalOnOff : MonoBehaviour
{
    Material mat;
    bool showDecal = false;

    void OnMouseDown()
    {
        showDecal = ! showDecal;
        if (showDecal)
            mat.SetFloat("_ShowDecal", 1);
        else
            mat.SetFloat("_ShowDecal", 0);
    }
    private void Start()
    {
        mat = this.GetComponent<Renderer>().sharedMaterial;
    }
}
