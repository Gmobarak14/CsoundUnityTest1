using UnityEngine;

public class PlayerMovement : MonoBehaviour
{
    [Header("Movement")]
    public float MoveSpeed;
   
    public float groundDrag;

    [Header("Ground Check")]
    public float PlayerHeight;
    public LayerMask whatIsGround;
    bool grounded;
    
    
    public Transform orientation; 
    float horizontalInput; 
    float verticalInput;
     Vector3 MoveDirection; 
     Rigidbody rb;

    private void Start(){
        rb = GetComponent<Rigidbody>();
        rb.freezeRotation = true;
     }


    void Update(){
        grounded = Physics.Raycast(transform.position, Vector3.down, PlayerHeight * 0.5f + 0.2f, whatIsGround);
        MyInput();
        SpeedControl();
        if (grounded)
            rb.drag = groundDrag;
        else
            rb.drag = 0;
        
    }
     private void FixedUpdate() {
        MovePlayer();
        
    }
    private void MyInput(){
        horizontalInput = Input.GetAxisRaw("Horizontal");
         verticalInput = Input.GetAxisRaw("Vertical");
    }
    private void MovePlayer(){
        MoveDirection = orientation.forward * verticalInput + orientation.right * horizontalInput;
        rb.AddForce(MoveDirection.normalized * MoveSpeed*10f, ForceMode.Force);
    }
    private void SpeedControl(){
        Vector3 flatVel = new Vector3(rb.velocity.x, 0f, rb.velocity.z);
        if(flatVel.magnitude > MoveSpeed){
            Vector3 limitedVel = flatVel.normalized * MoveSpeed;
            rb.velocity = new Vector3(limitedVel.x,rb.velocity.y, limitedVel.z);
        }
    }

}
