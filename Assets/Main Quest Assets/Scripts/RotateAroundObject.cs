using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RotateAroundObject : MonoBehaviour
{

    public float speed;
    public Transform target;

	void Start ()
    {
    }

    void Update ()
    {
        transform.RotateAround(target.position, target.up, 20 * Time.deltaTime * speed);
        //transform.LookAt(target);
    }

}
