use hello::make_string;

fn main() {
    let val = make_string("hello", "rust");
    println!("{}", val);
    let val = make_string("rust", "hello");
    println!("{}", val);
}
