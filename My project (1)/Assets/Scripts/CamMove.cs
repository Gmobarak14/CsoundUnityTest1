using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CamMove : MonoBehaviour
{
    public Transform cameraPosition; 
    void Update()
    {
        transform.position = cameraPosition.position;
    }
}
